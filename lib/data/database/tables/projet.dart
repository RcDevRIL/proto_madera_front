
import 'package:moor_flutter/moor_flutter.dart';

class Projet extends Table {
  IntColumn get projetId => integer().autoIncrement()();

  @override
  Set<Column> get primaryKey => {projetId};

  TextColumn get nomProjet => text().withLength(min: 0, max: 50)();

  TextColumn get refProjet => text().withLength(min: 0, max: 45)();

  DateTimeColumn get dateProjet => dateTime()();

  RealColumn get prixTotal => real().nullable()();

  IntColumn get clientId => integer()();

  IntColumn get devisEtatId => integer()();

  BoolColumn get isSynchro => boolean()();
}