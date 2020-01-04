import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/produit.dart';

part 'produit_dao.g.dart';

@UseDao(tables: [Produit])
class ProduitDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitDaoMixin {
  ProduitDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ProduitData> listProduit) async {
    //TODO revoir le delete (ca va tout casser)
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
    return await into(produit).insert(produitData);
  }

  Future<List<ProduitData>> getProduitModeleByGammeId(int gammeId) async {
    return await (select(produit)..where((pd) {
      return pd.gammesId.equals(gammeId) & pd.modele.equals(true);
    })).get();
  }
}
