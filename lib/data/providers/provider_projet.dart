import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/daos.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/quote_creation_model.dart';
import 'package:proto_madera_front/data/models/quote_model.dart';

///
/// Provider to handle user input inside quote creation module
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderProjet with ChangeNotifier {
  QuoteCreationModel _quoteCreationValues;
  QuoteModel _quoteValues;
  int _editModuleIndex;
  int _editProductIndex;
  List<QuoteModel> productList;
  bool canInit = true;

  MaderaDatabase db;
  GammeDao gammeDao;
  ProduitDao produitDao;
  ProduitModuleDao produitModuleDao;
  ModuleDao moduleDao;
  List<DatabaseAccessor<MaderaDatabase>> daosSynchroList;

  //Données ref
  List<GammeData> listGammes;
  List<ProduitData> listProduitModele;
  List<ProduitModuleData> listProduitModule;
  List<ModuleData> listModule;

  final Logger log = Logger();
  final String _now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()
          .substring(0, 10);

  ProviderProjet({@required this.db, @required this.daosSynchroList}) {
    for (DatabaseAccessor<MaderaDatabase> dao in daosSynchroList) {
      switch (dao.runtimeType) {
        case GammeDao:
          gammeDao = dao;
          break;
        case ModuleDao:
          moduleDao = dao;
          break;
        case ProduitModuleDao:
          produitModuleDao = dao;
          break;
        case ProduitDao:
          produitDao = dao;
          break;
        default:
          log.e("ERROR, NO DAO ASSIGNED TO THIS VALUE: ${dao.runtimeType}");
      }
    }
  }

  void initAndHold() {
    //TODO Appeler cette méthode à chaque fois qu'on fait une redirection vers QuoteCreation
    if (canInit)
      init();
    else
      log.e('Can' 't init a new project, save first');
  }

  void validate(bool saveIt) {
    if (saveIt) {
      log.i('Saving project with following values...');
      log.i(_quoteCreationValues);
      productList.forEach((quoteModel) => log.i(quoteModel));
      //TODO save en bdd?, a faire coté ui je pense pour pouvoir utiliser provider.of(context)
      canInit = true;
    } else
      canInit = true;
  }

  void init() {
    var clientId = 123;
    log.i('init called');
    //Initialisation des données
    initData();
    canInit = false;
    // Initialisation des champs à null en respectant les conditions des constructeurs
    _quoteCreationValues = QuoteCreationModel(
      client: {
        'clientId': '$clientId',
        'name': '',
        'adresse': '',
        'tel': '',
        'mail': ''
      },
      dateDeCreation: _now,
      descriptionProjet: '',
      refProjet: _now +
          '_MMP$clientId', //à voir comment on construit nos ref de projet? j'ai mis yyyyMMdd_MMP123, MMP pour 'MaisonModulaireProjet', 123 pour l'ID client
    );
    productList = [];
    initProductCreationModel();
  }

  void deleteProductCreationModel(int productID) {
    productList.removeAt(productID);
    notifyListeners();
  }

  void loadProductCreationModel(int index) {
    _quoteValues = productList[index];
    _editProductIndex = index;
    notifyListeners();
  }

  void initProductCreationModel() {
    _quoteValues = QuoteModel(
        gamme: 'Premium',
        nomDeProduit: null,
        listeModele: {
          'Modèle Premium 1': 11,
          'Modèle Premium 2': 12,
          'Modèle Premium 3': 13,
        },
        listeModule: Map<String, dynamic>(),
        modeleChoisi: null);
    productList.add(_quoteValues);
    _editProductIndex = productList.indexOf(_quoteValues);
    notifyListeners();
  }

  void initData() async {
    await initGammes();
    await initModules();
    notifyListeners();
  }

  void initGammes() async {
    listGammes = await gammeDao.getAllGammes();
  }

  void initModules() async {
    listModule = await moduleDao.getAllModules();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void flush() {
    //TODO Enregistrer la configuration actuelle du devis en BDD
    canInit = true;
    initAndHold();
  }

  QuoteModel get quoteValues => _quoteValues;

  set editModuleIndex(int index) {
    _editModuleIndex = index;
    notifyListeners();
  }

  int get editModuleIndex => _editModuleIndex;

  int get editProductIndex => _editProductIndex;

  set dateCreation(String newDate) {
    _quoteCreationValues.dateDeCreation = newDate;
    notifyListeners();
  }

  String get dateCreation => _quoteCreationValues.dateDeCreation.toString();

  set refProjet(String refProjet) {
    _quoteCreationValues.refProjet = refProjet;
    notifyListeners();
  }

  String get refProjet => _quoteCreationValues.refProjet;

  void setDescription(String desc) {
    _quoteCreationValues.descriptionProjet = desc;
    notifyListeners();
  }

  String get description => _quoteCreationValues.descriptionProjet;

  set client(Map<String, String> newClient) {
    _quoteCreationValues.client = newClient;
  }

  Map<String, String> get client => _quoteCreationValues.client;

  set clientName(String clientName) {
    _quoteCreationValues.client
        .update('name', (old) => clientName, ifAbsent: () => clientName);
    notifyListeners();
  }

  String get clientName => _quoteCreationValues.client['name'];

  set clientAdress(String clientAdress) {
    _quoteCreationValues.client
        .update('adresse', (old) => clientAdress, ifAbsent: () => clientAdress);
    notifyListeners();
  }

  String get clientAdress => _quoteCreationValues.client['adresse'];

  set clientTel(String clientTel) {
    _quoteCreationValues.client
        .update('tel', (old) => clientTel, ifAbsent: () => clientTel);
    notifyListeners();
  }

  String get clientTel => _quoteCreationValues.client['tel'];

  set clientMail(String clientMail) {
    _quoteCreationValues.client
        .update('mail', (old) => clientMail, ifAbsent: () => clientMail);
    notifyListeners();
  }

  String get clientMail => _quoteCreationValues.client['mail'];

  void setNomDeProduit(String nomDeProduit) {
    _quoteValues.nomDeProduit = nomDeProduit;
    notifyListeners();
  }

  String get nomDeProduit => _quoteValues.nomDeProduit;

  void setGamme(String nomGamme) {
    _quoteValues.gamme = nomGamme;
    notifyListeners();
  }

  String get gamme => _quoteValues.gamme;

  void setModel(String nomModel) {
    _quoteValues.modeleChoisi = nomModel;
    notifyListeners();
  }

  String get model => _quoteValues.modeleChoisi;

  void updateModuleInfos(Map<String, dynamic> moduleSpec) {
    _quoteValues.listeModule.remove(
        _quoteValues.listeModule.entries.elementAt(editModuleIndex).key);
    _quoteValues.listeModule.addAll({'${moduleSpec['name']}': moduleSpec});
  }

  Map<String, dynamic> get productModules => _quoteValues.listeModule;

  Map<String, dynamic> get modeleList => _quoteValues.listeModele;

  void initListProduitModule(int produitModeleId) async {
    listProduitModule =
        await produitModuleDao.getProduitModuleByProduitId(produitModeleId);
    notifyListeners();
  }

  void initListProduitModele(int gammeID) async {
    listProduitModele = await produitDao.getProduitModeleByGammeId(gammeID);
    notifyListeners();
  }

  void logQC() {
    log.i('QuoteCreation values:\n$_quoteCreationValues');
  }

  void logQ() {
    log.i('Quote values:\n${_quoteValues.toString()}');
  }

  bool isFilled(String pageName) {
    switch (pageName) {
      case 'QuoteCreation':
        return (clientAdress.isNotEmpty &&
            clientName.isNotEmpty &&
            clientTel.isNotEmpty &&
            clientMail.isNotEmpty &&
            description.isNotEmpty);
        break;
      case 'ProductCreation':
        return (nomDeProduit != null);
        break;
      case 'AddModule':
        return (productModules.values
            .elementAt(editModuleIndex)['nature']
            .isNotEmpty);
        break;
      default:
        return false;
        break;
    }
  }

  void updateModuleNature(String newValue) {
    productModules.values.elementAt(editModuleIndex)['nature'] = newValue;
    notifyListeners();
  }

  void setFinitions(String choice) {
    productModules.values
        .elementAt(editModuleIndex)
        .addAll({'finitions': choice});
  }
}
