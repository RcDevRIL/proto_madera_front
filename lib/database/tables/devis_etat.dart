
import 'package:moor_flutter/moor_flutter.dart';

class DevisEtat extends Table {

  IntColumn get devisEtatId => integer()();

  TextColumn get devisEtatLibelle => text()();

  IntColumn get pourcentageSomme => integer()();
}