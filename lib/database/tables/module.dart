
import 'package:moor_flutter/moor_flutter.dart';

class Module extends Table {
  IntColumn get moduleId => integer()();

  IntColumn get gammeId => integer()();

  //Module referentiel

  IntColumn get moduleReferentielId => integer()();

  TextColumn get caracteristiqueReferentiel => text()();

  TextColumn get uniteUsage => text()();

  //Nom du module
  TextColumn get nom => text()();

  TextColumn get natureModule => text()();

}