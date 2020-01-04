import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/produit_module.dart';

part 'produit_module_dao.g.dart';

@UseDao(tables: [ProduitModule])
class ProduitModuleDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitModuleDaoMixin {
  ProduitModuleDao(MaderaDatabase db) : super(db);
  ///Méthode de synchronisation
  Future insertAll(List<ProduitModuleData> listProduitModule) async {
    await delete(produitModule).go();
    await db.batch((b) => b.insertAll(produitModule, listProduitModule));
  }


  Future createProduitModule(int produitId, ProduitModuleData produitModuleData) async {
    //TODO il va avoir des problèmes sur le final de la variable ainsi que plein de required dans la construction !
    //produitModuleData.produitId = produitId;
    await into(produitModule).insert(produitModuleData);
  }

  Future<List<ProduitModuleData>> getProduitModuleByProduitId(int produitId) async {
    return await (select(produitModule)..where((pm) => pm.produitId.equals(produitId))).get();
  }
}
