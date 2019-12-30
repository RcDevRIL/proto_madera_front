
import 'package:moor_flutter/moor_flutter.dart';

class ComposantGroupe extends Table {
  IntColumn get composantGroupeId => integer()();

  TextColumn get libelleGroupe => text()();
}