import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/client.dart';

part 'client_dao.g.dart';

@UseDao(tables: [Client])
class ClientDao extends DatabaseAccessor<MaderaDatabase> with _$ClientDaoMixin {
  ClientDao(MaderaDatabase db) : super(db);

  String get queryClientOfProjetSynchro => "SELECT client.id FROM client "
      "LEFT JOIN projet ON projet.client_id = client.id "
      "WHERE projet.projet_id IS NULL "
      "OR projet.is_synchro = 1";

  Future insertAll(List<ClientData> listClient) async {
    await db.batch((b) => b.insertAll(client, listClient));
  }

  Future<List<ClientData>> getAllClient() async {
    return await select(client).get();
  }

  Future<int> deleteAll() async {
    //Récupère la liste des moduleComposant qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listClientId =
        await customSelectQuery(queryClientOfProjetSynchro, readsFrom: {client})
            .get()
            .then(
              (rows) => rows
                  .map<int>(
                    (row) => row.readInt("id"),
                  )
                  .toList(),
            );
    return await (delete(client)..where((cli) => cli.id.isIn(listClientId)))
        .go();
  }
}
