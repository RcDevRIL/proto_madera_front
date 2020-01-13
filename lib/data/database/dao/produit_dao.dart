import 'package:flutter/cupertino.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/produit.dart';
import 'package:proto_madera_front/data/models/models.dart';

part 'produit_dao.g.dart';

@UseDao(tables: [Produit])
class ProduitDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitDaoMixin {
  ProduitDao(MaderaDatabase db) : super(db);
  String get queryProduitOfProjetIsSynchro =>
      "SELECT produit.produit_id from produit "
      "LEFT JOIN projet_produits ON projet_produits.produit_id "
      "LEFT JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL";

  String get queryGetListProduitByProjetId => "SELECT * from produit "
      "JOIN projet_produits ON projet_produits.produit_id = produit.produit_id "
      "WHERE projet_produits.projet_id =";

  ///Ajout d'une liste de produit / utilisée lors de la méthode de synchro
  Future insertAll(List<ProduitData> listProduit) async {
    await db.batch((b) =>
        b.insertAll(produit, listProduit, mode: InsertMode.insertOrReplace));
  }

  ///Création d'un produit
  Future createProduit(ProduitData produitData) async {
    ProduitCompanion produitCompanion;
    if (produitData.produitId != -1 && produitData.produitId != null) {
      produitCompanion = ProduitCompanion(
          produitId: Value(produitData.produitId),
          produitNom: Value(produitData.produitNom),
          modele: Value(produitData.modele),
          gammesId: Value(produitData.gammesId),
          prixProduit: Value(produitData.prixProduit));
    } else {
      produitCompanion = ProduitCompanion(
        produitNom: Value(produitData.produitNom),
        modele: Value(produitData.modele),
        gammesId: Value(produitData.gammesId),
      );
    }
    return await into(produit).insert(
      produitCompanion,
    );
  }

  ///Recupere les produits en fonction de la gamme et s'ils sont un models ou non
  Future<List<ProduitData>> getProduitModeleByGammeId(int gammeId) async {
    return await (select(produit)
          ..where(
            (pd) {
              return pd.gammesId.equals(gammeId) & pd.modele.equals(true);
            },
          ))
        .get();
  }

  ///Supprime les occurences
  Future<int> deleteAll() async {
    List<int> listProduitId = await customSelectQuery(
            queryProduitOfProjetIsSynchro,
            readsFrom: {produit}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("produit_id"),
              )
              .toList(),
        );
    return await (delete(produit)
          ..where(
            (prd) => prd.produitId.isIn(listProduitId),
          ))
        .go();
  }

  Future<List<ProduitData>> getListProduitByProjetId(int projetId) async {
    List<ProduitData> listProduitData = await customSelectQuery(
        queryGetListProduitByProjetId + projetId.toString(),
            readsFrom: {produit}).get().then(
          (rows) => rows
              .map<ProduitData>(
                (row) => ProduitData.fromData(row.data, db),
              )
              .toList(),
        );
    return listProduitData;
  }
}
