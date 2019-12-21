import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/utilisateur.dart';

part 'utilisateur_dao.g.dart';

@UseDao(tables: [Utilisateur])
class UtilisateurDao extends DatabaseAccessor<MaderaDatabase>
    with _$UtilisateurDaoMixin {
  UtilisateurDao(MaderaDatabase db) : super(db);

  //Ajoute ou remplace l'utilisateur
  Future insertUser(UtilisateurData entry) async {
    await delete(utilisateur).go();
    await db.batch((b) => b.insert(utilisateur, entry));
  }

  Future<UtilisateurData> getUser() async {
    return await (select(utilisateur)).getSingle();
  }

  //Supprime le contenu de utilisateur
  Future deleteUser() async {
    await delete(utilisateur).go();
  }
}
