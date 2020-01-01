import 'package:moor_flutter/moor_flutter.dart';

class Client extends Table {
  IntColumn get id => integer().autoIncrement()();

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get nom => text().withLength(
        min: 0,
        max: 45,
      )();

  TextColumn get prenom => text().withLength(
        min: 0,
        max: 45,
      )();

  TextColumn get numTel => text().withLength(
        min: 0,
        max: 10,
      )();

  TextColumn get mail => text().withLength(
        min: 0,
        max: 45,
      )();
}
