
import 'package:moor_flutter/moor_flutter.dart';

class Gamme extends Table {
  IntColumn get gammeId => integer()();

  TextColumn get libelleGammes => text()();
}