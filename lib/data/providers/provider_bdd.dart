import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:proto_madera_front/data/database/dao/database_dao.dart';
import 'package:proto_madera_front/data/database/daos.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/projet_with_client.dart';

///
/// Provider to handle database interactions
///
///   Expose DAOs
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderBdd with ChangeNotifier {
  MaderaDatabase db = new MaderaDatabase();
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
    ]; // En gros on met dans cette liste que ce que synchro a besoin. Mais c'est bien ce provider qui est censé donner l'accès à la base de données!
  }

  void drop() {
    //Drop la base de données
    DatabaseDao(db).drop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO a voir mais risque d'avoir un problème sur tous les constructeurs ! peut être créer des models ?
//TODO ajouter un boolean synchro et l'init a false, il se passe que lorsqu'il est renseigné côté serveur
  ///Méthode pour créer le projet ainsi que ses produits (infos relatives aux produits, produitModule..)
  void createAll(ProjetData projetData,
      List<ProduitWithModule> listProduitWithModule) async {
    //TODO a tester, ça renvoyer un id genere
    int projetId = await createProject(projetData);
    print(projetId);
    //Si le projet a été créé alors on continue
    if (projetId != 0) {
      var produitId;
      listProduitWithModule.forEach((produitWithModule) async => {
            //TODO a tester, ça renvoyer un id genere
            produitId = await createProduit(produitWithModule.produit),
            //Si la somme de isProduitCreated est égal à la longueur des éléments dans listProduit, alors on continue
            if (produitId != 0)
              {
                createProjetProduit(projetId, produitId),
                //TODO il va avoir des problèmes sur le final de la variable ainsi que plein de required dans la construction !
                createProduitModule(
                    produitId, produitWithModule.listProduitModule),
              }
          });
    }
  }

  ///Appel du dao pour la création d'un projet
  Future<int> createProject(ProjetData projetData) async {
    int isCreated = await projetDao.createProject(projetData);
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
}
