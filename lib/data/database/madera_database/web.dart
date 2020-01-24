import 'package:moor/moor_web.dart';

import 'package:proto_madera_front/data/database/madera_database.dart';

MaderaDatabase constructDb({bool logStatements = false}) => MaderaDatabase(
      WebDatabase(
        'madera_db',
        logStatements: logStatements,
      ),
    );
