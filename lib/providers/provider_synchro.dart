import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:proto_madera_front/constants/url.dart';
import 'package:proto_madera_front/database/dao/composant_dao.dart';
import 'package:proto_madera_front/database/dao/utilisateur_dao.dart';
import 'package:proto_madera_front/database/madera_database.dart';

class ProviderSynchro with ChangeNotifier {
  //TODO A revoir, faut que je regarde au travail
  final log = Logger();
  static MaderaDatabase db = new MaderaDatabase();
  UtilisateurDao utilisateurDao = new UtilisateurDao(db);
  ComposantDao composantDao = new ComposantDao(db);

  //Synchro referentiel
  void synchroReferentiel() async {
    UtilisateurData utilisateurData = await utilisateurDao.getUser();
    String token = utilisateurData.token;
    var response;
    try {
      //TODO passer en param la derniere date de synchro ?
      response = await http
          .get(urlSynchroRef, headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log.e("Error when tryiing to connect:\n" + e.toString());
    }
    //TODO Try catch ?
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ComposantData> listComposant = (data['composant'] as List)
          .map((a) => ComposantData.fromJson(a))
          .toList();

      composantDao.insertAll(listComposant);
    } else {
      log.e("Erreur lors de la synchronisation des données");
    }
    //TODO Renvoyer un message d'erreur
  }
}
