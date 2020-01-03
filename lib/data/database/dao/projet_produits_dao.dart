import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/projet_produits.dart';

part 'projet_produits_dao.g.dart';

@UseDao(tables: [ProjetProduits])
class ProjetProduitsDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProjetProduitsDaoMixin {
  ProjetProduitsDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ProjetProduit> listProjetPoduit) async {
    await delete(projetProduits).go();
    await db.batch((b) => b.insertAll(projetProduits, listProjetPoduit));
  }
}
