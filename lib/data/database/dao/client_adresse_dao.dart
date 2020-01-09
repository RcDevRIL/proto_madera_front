import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/client_adresse.dart';

part 'client_adresse_dao.g.dart';

@UseDao(tables: [ClientAdresse])
class ClientAdresseDao extends DatabaseAccessor<MaderaDatabase>
    with _$ClientAdresseDaoMixin {
  ClientAdresseDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ClientAdresseData> listClientAdresse) async {
    await delete(clientAdresse).go();
    await db.batch((b) => b.insertAll(clientAdresse, listClientAdresse));
  }

  Future<int> getClientAdresseId(int clientId) async {
    int adresseId;
    await (select(clientAdresse)..where((cA) => (cA.clientId.equals(clientId))))
        .get()
        .then((listcAD) => listcAD.forEach((cAD) {
              if (cAD.adresseFacturation == true) adresseId = cAD.adresseId;
            }));
    return adresseId;
  }
}
