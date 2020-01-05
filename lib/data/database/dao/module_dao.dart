import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/module.dart';

part 'module_dao.g.dart';

@UseDao(tables: [Module])
class ModuleDao extends DatabaseAccessor<MaderaDatabase> with _$ModuleDaoMixin {
  ModuleDao(MaderaDatabase db) : super(db);

  String get queryNatureModule => "SELECT DISTINCT module.nature_module FROM module";

  Future insertAll(List<ModuleData> listModule) async {
    await delete(module).go();
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
    /*return await select(module).get().then((rows) {
      return rows.map<String>((row) {
        return row.natureModule;
      }).toList();
    });*/
  }
}
