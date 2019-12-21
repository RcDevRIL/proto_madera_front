import 'package:flutter/material.dart';

import 'package:proto_madera_front/database/dao/database_dao.dart';
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

  void drop() {
    DatabaseDao(db).drop();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
