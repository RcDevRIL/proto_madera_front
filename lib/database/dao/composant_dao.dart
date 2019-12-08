import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/composant.dart';

part 'composant_dao.g.dart';

@UseDao(tables: [Composant])
class ComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantDaoMixin {
  ComposantDao(MaderaDatabase db) : super(db);

  void insertAll(List<ComposantData> listEntry) {
    delete(composant).go();
    into(composant).insertAll(listEntry);
  }
}
