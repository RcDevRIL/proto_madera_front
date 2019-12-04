import 'package:flutter/material.dart';
import 'package:proto_madera_front/database/dao/database_dao.dart';
import 'package:proto_madera_front/database/madera_database.dart';

///
/// TODO Provider permettant de gérer l'état de la synchronisation avec la base de donnée distante
/// TODO Permet également de gérer la sauvegarde locale
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class ProviderBdd with ChangeNotifier {
  String _lastSyncDate;

  String get lastSyncDate => _lastSyncDate ??= '2019-12-02 23:00:00';

  static MaderaDatabase db = new MaderaDatabase();
  DatabaseDao databaseDao = new DatabaseDao(db);

  void drop() {
    databaseDao.drop();
  }
}
