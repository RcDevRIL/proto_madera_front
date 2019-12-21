import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/module_composant.dart';

part 'module_composant_dao.g.dart';

@UseDao(tables: [ModuleComposant])
class ModuleComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ModuleComposantDaoMixin {
  ModuleComposantDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ModuleComposantData> listModuleComposant) async {
    await delete(moduleComposant).go();
    await db.batch((b) => b.insertAll(moduleComposant, listModuleComposant));
  }
}
