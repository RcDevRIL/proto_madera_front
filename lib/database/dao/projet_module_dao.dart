
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/projet_module.dart';

part 'projet_module_dao.g.dart';

@UseDao(tables: [ProjetModule])
class ProjetModuleDao extends DatabaseAccessor<MaderaDatabase> with _$ProjetModuleDaoMixin {
  ProjetModuleDao(MaderaDatabase db) : super(db);
}