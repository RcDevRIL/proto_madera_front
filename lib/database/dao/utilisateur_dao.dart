
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/utilisateur.dart';

part 'utilisateur_dao.g.dart';

@UseDao(tables: [Utilisateur])
class UtilisateurDao extends DatabaseAccessor<MaderaDatabase> with _$UtilisateurDaoMixin {
    UtilisateurDao(MaderaDatabase db) : super(db);

    void insertUser(UtilisateurCompanion entry) {
      into(utilisateur).insert(entry);
    }
}