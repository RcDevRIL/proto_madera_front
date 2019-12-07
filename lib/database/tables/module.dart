
import 'package:moor_flutter/moor_flutter.dart';

class Module extends Table {
  IntColumn get moduleId => integer()();

  IntColumn get gammeId => integer()();

  //Module referentiel

  @JsonKey("moduleReferentiel.moduleReferentielId")
  IntColumn get moduleReferentielId => integer()();

  @JsonKey("moduleReferentiel.caracteristiqueReferentiel")
  TextColumn get caracteristiqueReferentiel => text()();

  @JsonKey("moduleReferentiel.uniteUsage")
  TextColumn get uniteUsage => text()();

  //Nom du module
  TextColumn get nom => text()();

  TextColumn get angle => text()();

  TextColumn get natureModule => text()();

  BoolColumn get modele => boolean()();

}