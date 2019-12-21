import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/client.dart';

part 'client_dao.g.dart';

@UseDao(tables: [Client])
class ClientDao extends DatabaseAccessor<MaderaDatabase> with _$ClientDaoMixin {
  ClientDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ClientData> listClient) async {
    await delete(client).go();
    await db.batch((b) => b.insertAll(client, listClient));
  }
}
