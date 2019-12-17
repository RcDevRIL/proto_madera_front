import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/composant.dart';

part 'composant_dao.g.dart';

@UseDao(tables: [Composant])
class ComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantDaoMixin {
  ComposantDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ComposantData> listEntry) async {
    await delete(composant).go();
    //TODO 'insertAll' is deprecated and shouldn't be used. Call batch() on a generated database, then use Batch.insertAll.
//Try replacing the use of the deprecated member with the replacement.
    await into(composant).insertAll(listEntry);
  }
}
