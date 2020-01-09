import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables.dart';
import 'package:proto_madera_front/data/models/projet_with_client.dart';

part 'projet_dao.g.dart';

@UseDao(tables: [Projet, Client])
class ProjetDao extends DatabaseAccessor<MaderaDatabase> with _$ProjetDaoMixin {
  ProjetDao(MaderaDatabase db) : super(db);

  String get selectProjetWithClient =>
      "SELECT * FROM projet JOIN client ON client.id = projet.client_id";

  String get queryProjetIfIsProjetSynchro =>
      "SELECT projet.projet_id FROM projet WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL";

  Future insertAll(List<ProjetData> listProjet) async {
    await db.batch((b) => b.insertAll(projet, listProjet, mode: InsertMode.insertOrReplace));
  }

  ///Récupère toute la liste des projetWithClient
  Future<List<ProjetWithClient>> getAll() async {
    return await customSelectQuery(
      selectProjetWithClient,
      readsFrom: {projet, client},
    )
        .get()
        .then(
          (rows) => rows
              .map(
                (row) => ProjetWithClient.fromData(row.data, db),
              )
              .toList(),
        )
        .catchError((error) => print(error));
  }

  ///Méthode de création d'un projet
  Future<int> createProject(ProjetData projetData) async {
    ProjetCompanion projetCompanion;
    if (projetData.projetId != -1 && projetData.projetId != null) {
      projetCompanion = ProjetCompanion(
        projetId: Value(projetData.projetId),
        nomProjet: Value(projetData.nomProjet),
        refProjet: Value(projetData.refProjet),
        dateProjet: Value(
          projetData.dateProjet,
        ),
        clientId: Value(projetData.clientId),
        devisEtatId: Value(projetData.devisEtatId),
        prixTotal: Value(projetData.prixTotal),
        isSynchro: Value(projetData.isSynchro),
      );
    } else {
      projetCompanion = ProjetCompanion(
        nomProjet: Value(projetData.nomProjet),
        refProjet: Value(projetData.refProjet),
        dateProjet: Value(
          projetData.dateProjet,
        ),
        clientId: Value(projetData.clientId),
        devisEtatId: Value(projetData.devisEtatId),
        prixTotal: Value(projetData.prixTotal),
        isSynchro: Value(false),
      );
    }
    return await into(projet).insert(projetCompanion);
  }

  ///Supprime les occurences de projet
  Future<int> deleteAll() async {
    //Récupère la liste des projet qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listProjetId = await customSelectQuery(
            queryProjetIfIsProjetSynchro,
            readsFrom: {projet}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("projet_id"),
              )
              .toList(),
        );
    return await (delete(projet)
          ..where(
            (pro) => pro.projetId.isIn(listProjetId),
          ))
        .go();
  }
}
