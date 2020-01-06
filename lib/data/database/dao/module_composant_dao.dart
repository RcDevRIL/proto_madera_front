import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/module_composant.dart';

part 'module_composant_dao.g.dart';

@UseDao(tables: [ModuleComposant])
class ModuleComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ModuleComposantDaoMixin {
  ModuleComposantDao(MaderaDatabase db) : super(db);

  String get querySelectModuleComposantOfProjetSynchro =>
      "SELECT * FROM module_composant "
      "JOIN produit_module ON produit_module.module_id = module_composant.module_id "
      "JOIN projet_produits ON projet_produits.produit_id = produit_module.produit_id "
      "JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1";

  Future insertAll(List<ModuleComposantData> listModuleComposant) async {
    await db.batch((b) => b.insertAll(moduleComposant, listModuleComposant));
  }

  Future<int> deleteAll() async {
    //Récupère la liste des moduleComposant qui doivent être supprimés (en fonction de is_synchro de projet)
    //C'est une liste de moduleId, puisqu'il n'y pas de champ moduleComposantId
    List<int> listModuleId = await customSelectQuery(
            querySelectModuleComposantOfProjetSynchro,
            readsFrom: {moduleComposant}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("module_id"),
              )
              .toList(),
        );
    return await (delete(moduleComposant)
          ..where((mc) => mc.moduleId.isIn(listModuleId)))
        .go();
  }
}
