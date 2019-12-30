
import 'package:moor_flutter/moor_flutter.dart';

class Produit extends Table {
  IntColumn get produitId => integer().autoIncrement()();

  @override
  Set<Column> get primaryKey => {produitId};

  TextColumn get produitNom => text().withLength(min: 0, max: 50)();

  IntColumn get gammesId => integer()();

  RealColumn get prixProduit => real()();

  BoolColumn get modele => boolean()();

}