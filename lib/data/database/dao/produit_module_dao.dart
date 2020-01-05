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
    //await (delete(produitModule))go();
    await db.batch((b) => b.insertAll(produitModule, listProduitModule));
  }

  Future deleteAndInsertAll(List<ProduitModuleData> listProduitModule) async {
    await (delete(produitModule)).go();
    await db.batch((b) => b.insertAll(produitModule, listProduitModule));
  }

  Future createProduitModule(
    int produitId,
    ProduitModuleData produitModuleData,
  ) async {

    //Regarde si le module existe
    ProduitModuleData isProduitModuleExits;
    if(produitModuleData.projetModuleId != null) {
      isProduitModuleExits = await (select(produitModule)
        ..where(
                (p) => p.projetModuleId.equals(produitModuleData.projetModuleId)))
          .getSingle();
    }
    ProduitModuleCompanion produitModuleCompanion;
    if (isProduitModuleExits != null &&
        produitId != null &&
        produitModuleData.projetModuleId != -1 &&
        produitModuleData.projetModuleId != null) {
      produitModuleCompanion = ProduitModuleCompanion(
        produitModuleNom: Value(produitModuleData.produitModuleNom),
        produitId: Value(produitId),
        moduleId: Value(produitModuleData.moduleId),
        produitModuleAngle: Value(produitModuleData.produitModuleAngle),
        produitModuleSectionLongueur:
            Value(produitModuleData.produitModuleSectionLongueur),
      );
    } else {
      produitModuleCompanion = ProduitModuleCompanion(
        produitModuleNom: Value(produitModuleData.produitModuleNom),
        produitId: Value(produitId),
        moduleId: Value(produitModuleData.moduleId),
        produitModuleAngle: Value(produitModuleData.produitModuleAngle),
        produitModuleSectionLongueur:
            Value(produitModuleData.produitModuleSectionLongueur),
      );
    }
    await into(produitModule).insert(
      produitModuleCompanion,
    );
  }

  Future<List<ProduitModuleData>> getProduitModuleByProduitId(
      int produitId) async {
    return await (select(produitModule)
          ..where((pm) => pm.produitId.equals(produitId)))
        .get();
  }
}
