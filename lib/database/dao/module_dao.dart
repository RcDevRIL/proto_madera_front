import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/module.dart';

part 'module_dao.g.dart';

@UseDao(tables: [Module])
class ModuleDao extends DatabaseAccessor<MaderaDatabase> with _$ModuleDaoMixin {
  ModuleDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ModuleData> listModule) async {
    await delete(module).go();
    //TODO 'insertAll' is deprecated and shouldn't be used. Call batch() on a generated database, then use Batch.insertAll.
//Try replacing the use of the deprecated member with the replacement.
    await into(module).insertAll(listModule);
  }
}
