import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/adresse.dart';

part 'adresse_dao.g.dart';

@UseDao(tables: [Adresse])
class AdresseDao extends DatabaseAccessor<MaderaDatabase>
    with _$AdresseDaoMixin {
  AdresseDao(MaderaDatabase db) : super(db);

  Future insertAll(List<AdresseData> listAdresse) async {
    await delete(adresse).go();
    //TODO 'insertAll' is deprecated and shouldn't be used. Call batch() on a generated database, then use Batch.insertAll.
//Try replacing the use of the deprecated member with the replacement.
    await into(adresse).insertAll(listAdresse);
  }
}
