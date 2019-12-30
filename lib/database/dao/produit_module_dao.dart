import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/produit_module.dart';

part 'produit_module_dao.g.dart';

@UseDao(tables: [ProduitModule])
class ProduitModuleDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitModuleDaoMixin {
  ProduitModuleDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ProduitModuleData> listProduitModule) async {
    await delete(produitModule).go();
    await db.batch((b) => b.insertAll(produitModule, listProduitModule));
  }
}
