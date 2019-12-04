import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/utilisateur.dart';

part 'utilisateur_dao.g.dart';

@UseDao(tables: [Utilisateur])
class UtilisateurDao extends DatabaseAccessor<MaderaDatabase>
    with _$UtilisateurDaoMixin {
  UtilisateurDao(MaderaDatabase db) : super(db);

  //Ajoute ou remplace l'utilisateur
  void insertUser(UtilisateurCompanion entry) {
    //TODO temporaire
    delete(utilisateur).go();
    into(utilisateur).insert(entry);
  }

  Future<UtilisateurData> getUser() async {
    return (select(utilisateur)).getSingle();
  }

  //Supprime l'utilisateur
  void deleteUser(String login) {
    delete(utilisateur).where((user) => user.login.equals(login));
  }
}
