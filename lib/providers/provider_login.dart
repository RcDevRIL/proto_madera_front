import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:proto_madera_front/providers/http_status.dart';

///
/// Provider permettant de gérer la connexion au backend hébergé
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class ProviderLogin with ChangeNotifier {
  final log = Logger();
  HttpStatus status = HttpStatus.OFFLINE;
  //TODO Externaliser les url dans un autre fichier ?
  var url = "https://cesi-madera.fr/madera";

  HttpStatus get getStatus => status ??= HttpStatus.OFFLINE;

  Future<bool> connection(String login, password) async {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var response;
    try {
      response = await http.post(
        url + '/authentification',
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'login': login, 'password': digest.toString()}),
      );
    } catch (e) {
      log.e("Error when trying to connect:\n" + e.toString());
    }
    if (response?.statusCode == 200 && response.body != 'false') {
      this.status = HttpStatus.ONLINE;
      return true;
    }
    if (response.body == 'false') {
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

  Future<bool> logout(String token) async {
    //TODO Call API to remove token on remote bdd
    //TODO Remove token on local bdd
    log.d('User logged out. Remove token : $token');
    this.status = HttpStatus.OFFLINE;
    return true;
  }
}
