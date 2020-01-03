
import 'package:moor_flutter/moor_flutter.dart';

class ProjetProduits extends Table {
  IntColumn get projetId => integer()();

  IntColumn get produitId => integer()();

  @override
  Set<Column> get primaryKey => {projetId, produitId};
}