import 'package:moor_flutter/moor_flutter.dart';

class ProjetModule extends Table {
  IntColumn get projetModuleId => integer().autoIncrement()();

  IntColumn get projetId => integer()();

  IntColumn get moduleId => integer()();
}
