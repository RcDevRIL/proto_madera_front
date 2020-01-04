import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/module.dart';

part 'module_dao.g.dart';

@UseDao(tables: [Module])
class ModuleDao extends DatabaseAccessor<MaderaDatabase> with _$ModuleDaoMixin {
  ModuleDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ModuleData> listModule) async {
    await delete(module).go();
    await db.batch((b) => b.insertAll(module, listModule));
  }

  Future<List<ModuleData>> getAllModules() async {
    return await select(module).get();
  }
}
