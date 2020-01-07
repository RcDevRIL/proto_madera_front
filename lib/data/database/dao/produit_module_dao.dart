import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/produit_module.dart';

part 'produit_module_dao.g.dart';

@UseDao(tables: [ProduitModule])
class ProduitModuleDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProduitModuleDaoMixin {
  ProduitModuleDao(MaderaDatabase db) : super(db);

  String get queryProduitModuleOfProjetIsSynchro =>
      "SELECT produit_module.projet_module_id FROM produit_module "
      "LEFT JOIN projet_produits ON projet_produits.produit_id = produit_module.produit_id "
      "LEFT JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL";

  ///Méthode de synchronisation
  Future insertAll(List<ProduitModuleData> listProduitModule) async {
    await db.batch((b) => b.insertAll(produitModule, listProduitModule));
  }

  ///Création d'un produitModule
  Future createProduitModule(
    int produitId,
    ProduitModuleData produitModuleData,
  ) async {
    //Regarde si le module existe
    ProduitModuleData isProduitModuleExits;
    if (produitModuleData.projetModuleId != null) {
      isProduitModuleExits = await (select(produitModule)
            ..where((p) =>
                p.projetModuleId.equals(produitModuleData.projetModuleId)))
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

  ///Supprime les occurences de produitModule
  Future<int> deleteAll() async {
    //Récupère la liste des produitModuleId qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listProduitModuleId = await customSelectQuery(
            queryProduitModuleOfProjetIsSynchro,
            readsFrom: {produitModule}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("projet_module_id"),
              )
              .toList(),
        );
    return await (delete(produitModule)
          ..where(
            (pm) => pm.projetModuleId.isIn(listProduitModuleId),
          ))
        .go();
  }
}
