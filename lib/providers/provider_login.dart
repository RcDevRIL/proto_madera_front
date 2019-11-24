import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:proto_madera_front/providers/http_status.dart';

class ProviderLogin with ChangeNotifier {
  final log = Logger();
  HttpStatus status = HttpStatus.OFFLINE;
  //TODO Externaliser les url dans un autre fichier ?
  // Url localhost Fab
  var url = "http://10.0.2.2:8081/madera";

  Future<bool> connection(String login, password) async {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var response;
    try {
      response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'login': login, 'password': digest.toString()}),
      );
    } catch (e) {
      log.e("Error when tryiing to connect:\n" + e.toString());
    }
    if (response?.statusCode == 200 && response.body != 'false') {
      this.status = HttpStatus.ONLINE;
      return true;
    }if (response.body == 'false') {
      this.status = HttpStatus.UNAUTHORIZED;
    }
    this.status = HttpStatus.OFFLINE;
    return false;
  }

  // Méthode pour vérifier si le serveur est joignable, vérification à effectuer
  // avant chaque méthode faisant des appels serveurs, sauf si le status est déjà offline
  Future<bool> ping() async {
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        this.status = HttpStatus.ONLINE;
        return true;
      }
    } catch (exception) {
      this.status = HttpStatus.OFFLINE;
      throw new Exception('Connection');
    }
    return false;
  }
}
