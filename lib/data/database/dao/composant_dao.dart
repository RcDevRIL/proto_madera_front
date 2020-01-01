import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/composant.dart';

part 'composant_dao.g.dart';

@UseDao(tables: [Composant])
class ComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantDaoMixin {
  ComposantDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ComposantData> listComposant) async {
    await delete(composant).go();
    await db.batch((b) => b.insertAll(composant, listComposant));
  }
}
