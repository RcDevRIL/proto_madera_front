import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/tables/utilisateur.dart';

part 'madera_database.g.dart';

@UseMoor(tables: [Utilisateur])
class MaderaDatabase extends _$MaderaDatabase {
  MaderaDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
          ),
        );
  @override
  int get schemaVersion => 1;
}
