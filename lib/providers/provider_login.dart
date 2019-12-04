import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/dao/database_dao.dart';
import 'package:proto_madera_front/database/dao/utilisateur_dao.dart';
import 'package:proto_madera_front/database/madera_database.dart';

import 'package:proto_madera_front/providers/http_status.dart';

///
/// Provider permettant de gérer la connexion au backend hébergé
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class ProviderLogin with ChangeNotifier {
  final log = Logger();
  HttpStatus status = HttpStatus.OFFLINE;
  //TODO Externaliser les url dans un autre fichier ?
  // Url localhost Fab
  var url = "http://10.0.2.2:8081/madera";
  // var url = "https://cesi-madera.fr/madera";
  //TODO A revoir, faut que je regarde au travail
  static MaderaDatabase db = new MaderaDatabase();
  UtilisateurDao utilisateurDao = new UtilisateurDao(db);
  DatabaseDao databaseDao = new DatabaseDao(db);

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
      log.e("Error when tryiing to connect:\n" + e.toString());
    }
    if (response?.statusCode == 200 && response.body != 'false') {
      this.status = HttpStatus.ONLINE;
      Map resp = jsonDecode(response.body);
      addUser(login, resp['token']);
      UtilisateurData user = await utilisateurDao.getUser(login);
      print(user);
      return true;
    }
    if (response.body == 'false') {
      this.status = HttpStatus.UNAUTHORIZED;
      return false;
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

  void addUser(String login, String token) {
    utilisateurDao.insertUser(UtilisateurCompanion(login: Value(login), token: Value(token)));
  }
}
