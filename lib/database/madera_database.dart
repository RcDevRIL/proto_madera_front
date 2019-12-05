import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/tables.dart';

part 'madera_database.g.dart';

@UseMoor(tables: [Utilisateur, Composant, Gamme])
class MaderaDatabase extends _$MaderaDatabase {
  MaderaDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite',
          ),
        );
  @override
  int get schemaVersion => 1;

  //TODO modifier un truc
}
