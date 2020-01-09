import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/projet_produits.dart';

part 'projet_produits_dao.g.dart';

@UseDao(tables: [ProjetProduits])
class ProjetProduitsDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProjetProduitsDaoMixin {
  ProjetProduitsDao(MaderaDatabase db) : super(db);

  String get queryProjetProduitOfProjetIsSynchro =>
      "SELECT projet_produits.projet_id FROM projet_produits "
      "LEFT JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL";

  ///Récupére toute la liste des projetProduits
  Future insertAll(List<ProjetProduit> listProjetPoduit) async {
    await db.batch((b) => b.insertAll(projetProduits, listProjetPoduit, mode: InsertMode.insertOrReplace));
  }

  ///Création d'un projetProduit
  Future createProjetProduit(int projetId, int produitId) async {
    await into(projetProduits).insert(
      ProjetProduitsCompanion(
        projetId: Value(projetId),
        produitId: Value(produitId),
      ),
    );
  }

  ///Supprime les occurrences de projetProduit
  Future<int> deleteAll() async {
    //Récupère la liste des produitModuleId qui doivent être supprimés (en fonction de is_synchro de projet)
    //Récupére une liste de projetId puisque la table n'a pas d'attribut projetProduitsId
    List<int> listProjetId = await customSelectQuery(
            queryProjetProduitOfProjetIsSynchro,
            readsFrom: {projetProduits}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("projet_id"),
              )
              .toList(),
        );
    return await (delete(projetProduits)
          ..where(
            (pP) => pP.projetId.isIn(listProjetId),
          ))
        .go();
  }
}
