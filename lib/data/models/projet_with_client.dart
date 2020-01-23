import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';

///
/// Model used to store a [ProjetData] with a [ClientData]
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class ProjetWithClient {
  final ProjetData projet;
  final ClientData client;

  ProjetWithClient(this.projet, this.client);

  factory ProjetWithClient.fromData(
    Map<String, dynamic> data,
    GeneratedDatabase db,
  ) {
    return ProjetWithClient(
      ProjetData.fromData(data, db),
      ClientData.fromData(data, db),
    );
  }
}
