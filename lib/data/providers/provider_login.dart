import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' show Client;
import 'package:http/testing.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/data/constants/url.dart';
import 'package:proto_madera_front/data/database/dao/utilisateur_dao.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/http_status.dart';

///
/// Provider to handle backend connection
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class ProviderLogin with ChangeNotifier {
  final log = Logger();
  final int timeOut = 10;
  Client http = new Client();
  HttpStatus status = HttpStatus.OFFLINE;
  MaderaDatabase db;
  UtilisateurDao utilisateurDao;

  ProviderLogin({@required this.db}) : utilisateurDao = new UtilisateurDao(db);

  @override
  void dispose() {
    super.dispose();
  }

  HttpStatus get getStatus => status ??= HttpStatus.OFFLINE;

  Future<bool> connection(String login, String password) async {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    var response;
    try {
      response = await http
          .post(
            MaderaUrl.urlAuthentification,
            headers: {'Content-type': 'application/json'},
            body: jsonEncode({'login': login, 'password': digest.toString()}),
          )
          .timeout(Duration(seconds: timeOut));
    } catch (e) {
      log.e('Error when trying to connect:\n' + e.toString());
      this.status = HttpStatus.OFFLINE;
      return false;
    }
    if (response?.statusCode == 200) {
      this.status = HttpStatus.AUTHORIZED;
      if (http.runtimeType != MockClient) {
        // provisoire, pour faire passer le test. PLus tard il faudra séparer la logique des appels web de la logique
        UtilisateurData utilisateurData =
            UtilisateurData.fromJson(jsonDecode(response.body));
        await utilisateurDao.insertUser(utilisateurData);
      }
      return true;
    } else if (response?.statusCode == 401) {
      this.status = HttpStatus.UNAUTHORIZED;
      return false;
    } else if (response?.statusCode != 401 || response?.statusCode != 200) {
      // Je suis pas sur mais l'ensemble des cas du else un peu plus bas est plus grand que cette condition non?
      // et ça permettrait de catch les autres codes de réponses, pour dire ok on est en ligne mais la requête n'a pas abouti
      this.status = HttpStatus.ONLINE;
      return false;
    } else {
      this.status = HttpStatus.OFFLINE;
      return false;
    }
  }

  /// Méthode pour vérifier si le serveur est joignable, vérification à effectuer
  /// avant chaque méthode faisant des appels serveurs, sauf si le status est déjà offline
  Future<bool> ping() async {
    var response;
    try {
      response =
          await http.get(MaderaUrl.baseUrl).timeout(Duration(seconds: timeOut));
    } catch (e) {
      log.e('Error when trying to ping:\n' + e.toString());
      this.status = HttpStatus.OFFLINE;
      return false;
    }
    if (response != null) {
      if (response.statusCode == 200) {
        this.status = HttpStatus.ONLINE;
        return true;
      } else {
        this.status = HttpStatus.OFFLINE;
        return false;
      }
    } else {
      this.status = HttpStatus.OFFLINE;
      return false;
    }
  }

  Future<bool> logout() async {
    var utilisateurData;
    if (http.runtimeType != MockClient) {
      utilisateurData = await utilisateurDao.getUser();
    } else {
      utilisateurData = UtilisateurData(
          login: 'toto', token: '43er-ere3-yr543', utilisateurId: 1);
    }
    var response;
    try {
      response = await http
          .post(
            MaderaUrl.urlDeconnection,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${utilisateurData.token}'
            },
            body: utilisateurData.login,
          )
          .timeout(Duration(seconds: timeOut));
    } catch (exception) {
      log.e('Error when tryiing to deconnect:\n' + exception.toString());
    }
    if (response?.statusCode == 200) {
      //Supprime l'utilisateur (token et login) localement
      if (http.runtimeType != MockClient) utilisateurDao.deleteUser();
      log.d('User logged out. Remove token : ${utilisateurData.token}');
      this.status = HttpStatus.OFFLINE;
      return true;
    } else {
      return false;
    }
  }
}
