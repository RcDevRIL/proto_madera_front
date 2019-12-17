import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/projet_module.dart';

part 'projet_module_dao.g.dart';

@UseDao(tables: [ProjetModule])
class ProjetModuleDao extends DatabaseAccessor<MaderaDatabase>
    with _$ProjetModuleDaoMixin {
  ProjetModuleDao(MaderaDatabase db) : super(db);

  Future insertAll(List<ProjetModuleData> listProjetModule) async {
    await delete(projetModule).go();
    //TODO 'insertAll' is deprecated and shouldn't be used. Call batch() on a generated database, then use Batch.insertAll.
//Try replacing the use of the deprecated member with the replacement.
    await into(projetModule).insertAll(listProjetModule);
  }
}
