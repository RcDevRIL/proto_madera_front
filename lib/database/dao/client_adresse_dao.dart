import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/client_adresse.dart';

part 'client_adresse_dao.g.dart';

@UseDao(tables: [ClientAdresse])
class ClientAdresseDao extends DatabaseAccessor<MaderaDatabase>
    with _$ClientAdresseDaoMixin {
  ClientAdresseDao(MaderaDatabase db) : super(db);
}
