import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';

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
