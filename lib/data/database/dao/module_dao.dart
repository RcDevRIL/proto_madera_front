import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/module.dart';

part 'module_dao.g.dart';

@UseDao(tables: [Module])
class ModuleDao extends DatabaseAccessor<MaderaDatabase> with _$ModuleDaoMixin {
  ModuleDao(MaderaDatabase db) : super(db);

  String get queryNatureModule =>
      "SELECT DISTINCT module.nature_module FROM module";

  String get querySelectModuleOfProjetSynchro => "SELECT * FROM module "
      "JOIN produit_module ON produit_module.module_id = module.module_id "
      "JOIN projet_produits ON projet_produits.produit_id = produit_module.produit_id "
      "JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1";

  Future insertAll(List<ModuleData> listModule) async {
    await db.batch((b) => b.insertAll(module, listModule));
  }

  Future<List<ModuleData>> getAllModules(String natureModule) async {
    return await (select(module)
          ..where(
            (m) => m.natureModule.equals(natureModule),
          ))
        .get();
  }

  Future<List<String>> getNatureModule() async {
    return customSelectQuery(queryNatureModule).get().then((rows) {
      return rows.map<String>((row) {
        return row.readString("nature_module");
      }).toList();
    });
  }

  ///Supprime les occurences de module
  Future<int> deleteAll() async {
    //Récupère la liste des modules qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listModuleId = await customSelectQuery(
            querySelectModuleOfProjetSynchro,
            readsFrom: {module}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("module_id"),
              )
              .toList(),
        );
    return await (delete(module)
          ..where(
            (module) => module.moduleId.isIn(listModuleId),
          ))
        .go();
  }
}
