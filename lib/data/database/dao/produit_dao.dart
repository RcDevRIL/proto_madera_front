import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/produit.dart';

part 'produit_dao.g.dart';

@UseDao(tables: [Produit])
class ProduitDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitDaoMixin {
  ProduitDao(MaderaDatabase db) : super(db);

  String get deleteProduitModele =>
      "DELETE * FROM produit where produit.modele == false";

  Future insertAll(List<ProduitData> listProduit) async {
    await delete(produit).go();
    await db.batch((b) => b.insertAll(produit, listProduit));
  }

  ///Insertion des produits client
  Future insertProduitClient(List<ProduitData> listProduit) async {
    await (delete(produit)..where((p) => p.modele.equals(false))).go();
    await db.batch((b) => b.insertAll(produit, listProduit));
  }

  ///Insertion des produits modele
  Future insertProduitModele(List<ProduitData> listProduit) async {
    await (delete(produit)..where((p) => p.modele.equals(true))).go();
    await db.batch((b) => b.insertAll(produit, listProduit));
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

  Future<List<ProduitData>> getProduitModeleByGammeId(int gammeId) async {
    return await (select(produit)
          ..where(
            (pd) {
              return pd.gammesId.equals(gammeId) & pd.modele.equals(true);
            },
          ))
        .get();
  }
}
