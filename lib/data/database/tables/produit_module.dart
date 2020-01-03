import 'package:moor_flutter/moor_flutter.dart';

class ProduitModule extends Table {
  IntColumn get projetModuleId => integer().autoIncrement()();

  @override
  Set<Column> get primaryKey => {projetModuleId};

  IntColumn get produitId => integer()();

  IntColumn get moduleId => integer()();

  TextColumn get produitModuleNom => text().withLength(min: 0, max: 50)();

  TextColumn get produitModuleAngle => text().withLength(min: 0, max: 30)();

  TextColumn get produitModuleSectionLongueur => text()();
}
