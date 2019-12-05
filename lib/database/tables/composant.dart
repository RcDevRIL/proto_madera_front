
import 'package:moor_flutter/moor_flutter.dart';

class Composant extends Table {
  IntColumn get composantId => integer()();
  //ComposantGroupe
  @JsonKey("composantGroupe.composantGroupeId")
  IntColumn get composantGroupeId => integer()();
  @JsonKey("composantGroupe.libelleGroupe")
  TextColumn get libelleGroupe => text()();
  TextColumn get libelle => text()();
  //ComposantReferentiel
  @JsonKey('composantReferentiel.composantReferentielId')
  IntColumn get composantReferentielId => integer()();
  @JsonKey('composantReferentiel.caracteristiqueReferentiel')
  TextColumn get caracteristiqueReferentiel => text()();
  @JsonKey('composantReferentiel.uniteUsage')
  TextColumn get uniteUsage => text()();
  RealColumn get section => real()();
  
}