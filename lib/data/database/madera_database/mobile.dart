import 'dart:io';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';

MaderaDatabase constructDb({bool logStatements = false}) {
  if (Platform.isIOS || Platform.isAndroid)
    return MaderaDatabase(
      FlutterQueryExecutor.inDatabaseFolder(
        path: 'madera_db.sqlite',
      ),
    );
  else
    return null;
}
