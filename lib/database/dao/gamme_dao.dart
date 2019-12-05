import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/gamme.dart';

part 'gamme_dao.g.dart';

@UseDao(tables: [Gamme])
class GammeDao extends DatabaseAccessor<MaderaDatabase>
    with _$GammeDaoMixin {
  GammeDao(MaderaDatabase db) : super(db);

  void insertAll(List<GammeData> listEntry) {
    into(gamme).insertAll(listEntry);
  }
}
