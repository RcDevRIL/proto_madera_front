import 'package:flutter/material.dart';

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
  ProjetDao projetDao;
  Stream<List<ProjetData>> listProjet;

  ///
  ///Constructeur par défaut de notre classe d'interaction avec la bdd.
  ///
  ///Permet d'initialiser nos DAO concernants les référentiels.
  ProviderBdd() {
    projetDao = new ProjetDao(this.db);
  }

  void drop() {
    DatabaseDao(db).drop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<ProjetData>> initProjetData() {
    this.listProjet = projetDao.getAll();
    return this.listProjet;
  }


}
