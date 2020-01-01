
import 'package:moor_flutter/moor_flutter.dart';

class ModuleComposant extends Table {

  IntColumn get moduleId => integer()();

  IntColumn get composantId => integer()();

  IntColumn get ordre => integer()();
}