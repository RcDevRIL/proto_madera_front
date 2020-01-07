import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/adresse.dart';

part 'adresse_dao.g.dart';

@UseDao(tables: [Adresse])
class AdresseDao extends DatabaseAccessor<MaderaDatabase>
    with _$AdresseDaoMixin {
  AdresseDao(MaderaDatabase db) : super(db);

  Future insertAll(List<AdresseData> listAdresse) async {
    deleteAll();
    await db.batch((b) => b.insertAll(adresse, listAdresse));
  }

  ///Supprimes les occurences
  Future<int> deleteAll() async {
    return await delete(adresse).go();
  }
}
