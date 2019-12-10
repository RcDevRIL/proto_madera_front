
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/projet.dart';

part 'projet_dao.g.dart';

@UseDao(tables: [Projet])
class ProjetDao extends DatabaseAccessor<MaderaDatabase> with _$ProjetDaoMixin {
  ProjetDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ProjetData> listProjet) async {
    await delete(projet).go();
    await into(projet).insertAll(listProjet);
  }
}