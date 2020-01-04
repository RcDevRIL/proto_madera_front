import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/gamme.dart';

part 'gamme_dao.g.dart';

@UseDao(tables: [Gamme])
class GammeDao extends DatabaseAccessor<MaderaDatabase> with _$GammeDaoMixin {
  GammeDao(MaderaDatabase db) : super(db);

  Future<List<GammeData>> getAllGammes() async {
    return await select(gamme).get();
  }

  Future insertAll(List<GammeData> listGamme) async {
    await delete(gamme).go();
    await db.batch((b) => b.insertAll(gamme, listGamme));
  }
}
