import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'package:proto_madera_front/database/dao/database_dao.dart';
import 'package:proto_madera_front/database/daos.dart';
import 'package:proto_madera_front/database/madera_database.dart';

///
/// Provider permettant de gérer l'état de la synchronisation avec la base de donnée distante
/// Permet également de gérer la sauvegarde locale
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
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
  ProjetModuleDao projetModuleDao;
  List<DatabaseAccessor<MaderaDatabase>> daosSynchroList;
  Stream<List<ProjetData>> listProjet;

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
    projetModuleDao = new ProjetModuleDao(db);
  }

  void drop() {
    DatabaseDao(db).drop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<DatabaseAccessor<MaderaDatabase>> getDaos() {
    return <DatabaseAccessor<MaderaDatabase>>[
      this.utilisateurDao,
      this.composantDao,
      this.gammeDao,
      this.moduleDao,
      this.moduleComposantDao,
      this.devisEtatDao,
      this.clientAdresseDao,
      this.clientAdresseDao,
      this.adresseDao,
      this.projetDao,
      this.projetModuleDao,
    ]; // En gros on met dans cette liste que ce que synchro a besoin. Mais c'est bien ce provider qui est censé donner l'accès à la base de données!
  }

  Stream<List<ProjetData>> initProjetData() {
    this.listProjet = projetDao.getAll();
    return this.listProjet;
  }
}
