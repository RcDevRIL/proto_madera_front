
import 'package:moor_flutter/moor_flutter.dart';

class Utilisateur extends Table {
  IntColumn get utilisateurId => integer()();
  TextColumn get login => text()();
  TextColumn get token => text()();
}