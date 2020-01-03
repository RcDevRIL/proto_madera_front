import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/composant_groupe.dart';

part 'composant_groupe_dao.g.dart';

@UseDao(tables: [ComposantGroupe])
class ComposantGroupeDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantGroupeDaoMixin {
  ComposantGroupeDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ComposantGroupeData> listComposantGroupe) async {
    await delete(composantGroupe).go();
    await db.batch((b) => b.insertAll(composantGroupe, listComposantGroupe));
  }
}
