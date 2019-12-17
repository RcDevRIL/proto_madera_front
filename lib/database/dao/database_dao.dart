
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/utilisateur.dart';

part 'database_dao.g.dart';

/*Classe relative à la base de données*/
@UseDao(tables: [Utilisateur])
class DatabaseDao extends DatabaseAccessor<MaderaDatabase> with _$DatabaseDaoMixin {
  DatabaseDao(MaderaDatabase db) : super(db);

  //Méthode suppresion bdd
  void drop() {
    delete(utilisateur).go();
  }

}