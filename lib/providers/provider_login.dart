import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:logger/logger.dart';
import 'package:proto_madera_front/constants/url.dart';
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
  Client http = new Client();
  final log = Logger();
  HttpStatus status = HttpStatus.OFFLINE;
  static MaderaDatabase db = new MaderaDatabase();
  UtilisateurDao utilisateurDao = new UtilisateurDao(db);

  HttpStatus get getStatus => status ??= HttpStatus.OFFLINE;

  Future<bool> connection(String login, password) async {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var response;
    try {
      response = await http.post(
        urlAuthentification,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'login': login, 'password': digest.toString()}),
      );
    } catch (e) {
      log.e("Error when tryiing to connect:\n" + e.toString());
      this.status = HttpStatus.OFFLINE;
      return false;
    }
    if (response?.statusCode == 200) {
      this.status = HttpStatus.ONLINE;
      this.status = HttpStatus.AUTHORIZED;
      UtilisateurData utilisateurData =
          UtilisateurData.fromJson(jsonDecode(response.body));
      await utilisateurDao.insertUser(utilisateurData);
      return true;
    }
    if (response?.statusCode == 401) {
      this.status = HttpStatus.UNAUTHORIZED;
      return false;
    } else {
      this.status = HttpStatus.OFFLINE;
      return false;
    }
  }

  // Méthode pour vérifier si le serveur est joignable, vérification à effectuer
  // avant chaque méthode faisant des appels serveurs, sauf si le status est déjà offline
  Future<bool> ping() async {
    try {
      var response = await http.get(baseUrl);
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

  Future<bool> logout() async {
    UtilisateurData utilisateurData = await utilisateurDao.getUser();
    var token = utilisateurData.token;
    var response;
    try {
      response = await http.post(
        urlDeconnection,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: utilisateurData.login,
      );
    } catch (exception) {
      log.e("Error when tryiing to deconnect:\n" + exception.toString());
    }
    if (response?.statusCode == 200) {
      //Supprime l'utilisateur (token et login) localement
      utilisateurDao.deleteUser();
      log.d('User logged out. Remove token : $token');
      this.status = HttpStatus.OFFLINE;
      return true;
    } else {
      return false;
    }
  }
}
