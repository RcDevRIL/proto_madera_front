import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:proto_madera_front/providers/http_status.dart';

class ProviderLogin with ChangeNotifier {

  HttpStatus status = HttpStatus.OFFLINE;
  //TODO Externaliser les url dans un autre fichier ?
  // Url localhost Fab
  var url = "http://10.0.2.2:8081/madera/authentification";
  // TODO suivant votre config l'adresse peut changer
  // TODO Faut vraiment qu'on déploie un serveur avec une bdd
  // Url localhost David
  //var url = "http://10.0.2.2:8081/madera/authentification";
  // Url localhost Romain
  //var url = "http://10.0.2.2:8081/madera/authentification";

  Future<bool> connection(String login, password) async {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({'login': login, 'password': digest.toString()}),
    );
    //TODO Ajouter au logger ?
    if (response.statusCode == 200 && response.body != 'false') {
      this.status = HttpStatus.ONLINE;
      return true;
    }
    this.status = HttpStatus.OFFLINE;
    return false;
  }
}
