import 'package:moor_flutter/moor_flutter.dart';

class ClientAdresse extends Table {
  IntColumn get clientId => integer()();

  IntColumn get adresseId => integer()();

  BoolColumn get adresseFacturation => boolean()();
}
