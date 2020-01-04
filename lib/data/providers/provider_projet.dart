import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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

  final Logger log = Logger();
  final String _now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()
          .substring(0, 10);

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

  void setModuleListFromModelID(int modelID) {
    //il faudra faire une requete ici
    _quoteValues.listeModule = Map<String, dynamic>();
    switch (modelID) {
      case 1:
        {
          _quoteValues.listeModule.clear();
          _quoteValues.listeModule.addAll(
            {
              'Module 1.1': {'name': 'Module 1.1', 'nature': 'Mur droit'},
              'Module 1.2': {'name': 'Module 1.2', 'nature': 'Mur droit'},
              'Module 1.3': {'name': 'Module 1.3', 'nature': 'Mur droit'},
            },
          );
        }
        break;
      case 2:
        {
          _quoteValues.listeModule.clear();
          _quoteValues.listeModule.addAll(
            {
              'Module 2.1': {'name': 'Module 2.1', 'nature': 'Mur droit'},
              'Module 2.2': {'name': 'Module 2.2', 'nature': 'Mur droit'},
              'Module 2.3': {'name': 'Module 2.3', 'nature': 'Mur droit'},
            },
          );
        }
        break;
      default:
        {
          log.e('Wrong modelID: $modelID');
        }
        break;
    }
    notifyListeners();
  }

  void setModeleListFromGammeID(int gammeID) {
    //il faudra faire une requete ici
    switch (gammeID) {
      case 1:
        {
          _quoteValues.listeModele = {
            'Modèle Premium 1': 11,
            'Modèle Premium 2': 12,
            'Modèle Premium 3': 13,
          };
          _quoteValues.listeModule = Map<String, dynamic>();
          _quoteValues.modeleChoisi = null;
        }
        break;
      case 2:
        {
          _quoteValues.listeModele = {
            'Modèle Standard 2.1': 21,
            'Modèle Standard 2.2': 22,
            'Modèle Standard 2.3': 23,
          };
          _quoteValues.listeModule = Map<String, dynamic>();
          _quoteValues.modeleChoisi = null;
        }
        break;
      default:
        {
          log.e('Wrong gammeID: $gammeID');
        }
        break;
    }
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
      case 'Quote':
        return (productModules.length != 0);
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
