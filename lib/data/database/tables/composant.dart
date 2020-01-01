
import 'package:moor_flutter/moor_flutter.dart';

class Composant extends Table {
  IntColumn get composantId => integer()();

  //ComposantGroupe
  IntColumn get composantGroupeId => integer()();

  TextColumn get libelleGroupe => text()();

  TextColumn get libelle => text()();

  //ComposantReferentiel
  IntColumn get composantReferentielId => integer()();

  TextColumn get caracteristiqueReferentiel => text()();

  TextColumn get uniteUsage => text()();

  RealColumn get section => real().nullable()();
  
}