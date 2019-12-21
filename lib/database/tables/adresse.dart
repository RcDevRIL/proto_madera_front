import 'package:moor_flutter/moor_flutter.dart';

class Adresse extends Table {
  IntColumn get adresseId => integer().autoIncrement()();

  TextColumn get ville => text().withLength(min: 0, max: 45)();

  TextColumn get codePostale => text().withLength(min: 0, max: 5)();

  TextColumn get rue => text().withLength(min: 0, max: 45)();

  TextColumn get complement => text().withLength(min: 0, max: 45)();

  TextColumn get numero => text().withLength(min: 0, max: 5)();
}
