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
}
