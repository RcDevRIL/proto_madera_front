import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/gamme.dart';

part 'gamme_dao.g.dart';

@UseDao(tables: [Gamme])
class GammeDao extends DatabaseAccessor<MaderaDatabase> with _$GammeDaoMixin {
  GammeDao(MaderaDatabase db) : super(db);

  String get queryGammeOfProjetIsSynchro => "SELECT gamme.gamme_id FROM gamme "
      "LEFT JOIN produit ON produit.gammes_id = gamme.gamme_id "
      "LEFT JOIN projet_produits ON projet_produits.produit_id = produit.produit_id "
      "LEFT JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL";

  Future<List<GammeData>> getAllGammes() async {
    return await select(gamme).get();
  }

  ///Ajout d'une liste de gammeData / utilisée lors de la méthode de synchro
  Future insertAll(List<GammeData> listGamme) async {
    await db.batch((b) => b.insertAll(gamme, listGamme, mode: InsertMode.insertOrReplace));
  }

  ///Supprime les occurrences de gamme
  Future<int> deleteAll() async {
    //Récupère la liste des gammeId qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listGammeId =
        await customSelectQuery(queryGammeOfProjetIsSynchro, readsFrom: {gamme})
            .get()
            .then(
              (rows) => rows
                  .map<int>(
                    (row) => row.readInt("gamme_id"),
                  )
                  .toList(),
            );
    return await (delete(gamme)
          ..where(
            (ga) => ga.gammeId.isIn(listGammeId),
          ))
        .go();
  }
}
