
import 'package:moor_flutter/moor_flutter.dart';

class Utilisateur extends Table {
  TextColumn get login => text()();
  TextColumn get token => text()();
}