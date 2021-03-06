import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:moor/moor.dart';
import 'package:proto_madera_front/data/database/dao/database_dao.dart';
import 'package:proto_madera_front/data/database/daos.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/madera_database/shared.dart';
import 'package:proto_madera_front/data/models/projet_with_all_infos.dart';
import 'package:proto_madera_front/data/models/projet_with_client.dart';

///
/// Provider to handle database interactions
///
///   Expose DAOs
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1.1
class ProviderBdd with ChangeNotifier {
  final log = Logger();
  static final MaderaDatabase db = constructDb(logStatements: true);
  UtilisateurDao utilisateurDao;
  ComposantDao composantDao;
  GammeDao gammeDao;
  ModuleDao moduleDao;
  ModuleComposantDao moduleComposantDao;
  DevisEtatDao devisEtatDao;
  ClientDao clientDao;
  ClientAdresseDao clientAdresseDao;
  AdresseDao adresseDao;
  ProjetDao projetDao;
  ProduitModuleDao produitModuleDao;
  ProduitDao produitDao;
  ComposantGroupeDao composantGroupeDao;
  ProjetProduitsDao projetProduitsDao;
  List<DatabaseAccessor<MaderaDatabase>> daosSynchroList;

  Future<List<ProjetWithClient>> listProjetWithClient;

  //Données ref / locale
  List<ClientData> listClient;
  List<GammeData> listGammes;
  List<ProduitData> listProduitModele;
  List<ProduitModuleData> listProduitModule;
  List<String> listNatureModule;
  List<ModuleData> listModule;

  int _editProjetID;
  ProjetWithClient projetWithClient;

  ///
  ///Constructeur par défaut de notre classe d'interaction avec la bdd.
  ///
  ///Permet d'initialiser nos DAO concernants les référentiels.
  ProviderBdd() {
    utilisateurDao = new UtilisateurDao(db);
    composantDao = new ComposantDao(db);
    gammeDao = new GammeDao(db);
    moduleDao = new ModuleDao(db);
    moduleComposantDao = new ModuleComposantDao(db);
    devisEtatDao = new DevisEtatDao(db);
    clientDao = new ClientDao(db);
    clientAdresseDao = new ClientAdresseDao(db);
    adresseDao = new AdresseDao(db);
    projetDao = new ProjetDao(db);
    produitDao = new ProduitDao(db);
    produitModuleDao = new ProduitModuleDao(db);
    composantGroupeDao = new ComposantGroupeDao(db);
    projetProduitsDao = new ProjetProduitsDao(db);
    daosSynchroList = <DatabaseAccessor<MaderaDatabase>>[
      utilisateurDao,
      composantDao,
      gammeDao,
      moduleDao,
      moduleComposantDao,
      devisEtatDao,
      clientDao,
      clientAdresseDao,
      adresseDao,
      projetDao,
      produitDao,
      produitModuleDao,
      composantGroupeDao,
      projetProduitsDao
    ];
  }

  void drop() {
    //Drop la base de données
    DatabaseDao(db).drop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Méthode pour créer le projet ainsi que ses produits (infos relatives aux produits, produitModule..)
  void createAll(ProjetWithAllInfos projetWithAllInfos) async {
    int projetId = await createProject(projetWithAllInfos.projet);
    //Si le projet a été créé alors on continue
    if (projetId != 0) {
      var produitId;
      projetWithAllInfos.listProduitWithModule.forEach(
        (produitWithModule) async => {
          produitId = await createProduit(produitWithModule.produit),
          //Si la somme de isProduitCreated est égal à la longueur des éléments dans listProduit, alors on continue
          if (produitId != 0)
            {
              createProjetProduit(projetId, produitId),
              createProduitModule(
                  produitId, produitWithModule.listProduitModule),
            }
        },
      );
    }
  }

  ///Appel du dao pour la création d'un projet
  Future<int> createProject(ProjetData projet) async {
    int isCreated = await projetDao.createProject(projet);
    return isCreated;
  }

  ///Appel du dao pour la création d'un produit
  Future<int> createProduit(ProduitData produitData) async {
    int isCreated = await produitDao.createProduit(produitData);
    return isCreated;
  }

  Future<int> createProjetProduit(int projetId, int produitId) async {
    int isCreated =
        await projetProduitsDao.createProjetProduit(projetId, produitId);
    return isCreated;
  }

  void createProduitModule(
      int produitId, List<ProduitModuleData> listProduitModule) {
    listProduitModule.forEach((produitModule) => {
          produitModuleDao.createProduitModule(
            produitId,
            produitModule,
          )
        });
  }

  Future<List<ProjetWithClient>> initProjetData() {
    this.listProjetWithClient = projetDao.getAll();
    return this.listProjetWithClient;
  }

  int get editProjetID => _editProjetID;

  void loadProjetWithClient(ProjetWithClient projetWithClient) {
    this.projetWithClient = projetWithClient;
    _editProjetID = projetWithClient.projet.projetId;
    notifyListeners();
  }

  void clearProjetWithClient() {
    this.projetWithClient = null;
    _editProjetID = null;
    notifyListeners();
  }

  Future initData() async {
    await initGammes();
    await initListNatureModule();
    await initClient();
  }

  Future initClient() async {
    listClient = await clientDao.getAllClient();
  }

  Future<String> buildClientAdresse(int clientId) async {
    StringBuffer sbuf = StringBuffer();
    int clientAdresseId = await clientAdresseDao.getClientAdresseId(clientId);
    AdresseData clientAdresseData =
        await adresseDao.getAdresse(clientAdresseId);
    sbuf.write(clientAdresseData.numero);
    sbuf.write(', ');
    sbuf.write(clientAdresseData.rue);
    sbuf.write(' ');
    sbuf.write(clientAdresseData.codePostale);
    sbuf.write(' ');
    sbuf.write(clientAdresseData.ville);
    return sbuf.toString();
  }

  Future initGammes() async {
    listGammes = await gammeDao.getAllGammes();
  }

  Future<bool> initModules(String natureModule) async {
    try {
      listModule = await moduleDao.getAllModules(natureModule);
    } catch (e) {
      log.e('$e');
      return false;
    }
    return true;
  }

  Future initListProduitModule(int produitModeleId) async {
    listProduitModule =
        await produitModuleDao.getProduitModuleByProduitId(produitModeleId);
    notifyListeners();
  }

  Future initListProduitModele(int gammeID) async {
    listProduitModele = await produitDao.getProduitModeleByGammeId(gammeID);
    notifyListeners();
  }

  Future initListNatureModule() async {
    listNatureModule = await moduleDao.getNatureModule();
  }

  ///Méthode appelée lors de l'édition
  Future loadProjetWithAllInfos() async {}
}
