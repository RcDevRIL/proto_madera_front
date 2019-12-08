import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:proto_madera_front/constants/url.dart';
import 'package:proto_madera_front/database/daos.dart';
import 'package:proto_madera_front/database/madera_database.dart';

class ProviderSynchro with ChangeNotifier {
  //TODO A revoir, faut que je regarde au travail
  final log = Logger();
  static MaderaDatabase db = new MaderaDatabase();
  UtilisateurDao utilisateurDao = new UtilisateurDao(db);
  ComposantDao composantDao = new ComposantDao(db);
  GammeDao gammeDao = new GammeDao(db);
  ModuleDao moduleDao = new ModuleDao(db);
  ModuleComposantDao moduleComposantDao = new ModuleComposantDao(db);

  void synchro() {
    synchroReferentiel();
    synchroData();
  }

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
    //TODO Factoriser dans une autre méthode ?
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ComposantData> listComposant = (data['composant'] as List)
          .map((a) => ComposantData.fromJson(a))
          .toList();

      List<GammeData> listGamme =
          (data['gammes'] as List).map((b) => GammeData.fromJson(b)).toList();

      List<ModuleData> listModule =
          (data['module'] as List).map((c) => ModuleData.fromJson(c)).toList();

      List<ModuleComposantData> listModuleComposant =
          (data['moduleComposant'] as List)
              .map((d) => ModuleComposantData.fromJson(d))
              .toList();

      //TODO Supprimer le contenu des tables à chaque synchro ?
      //Insertion des données en base
      composantDao.insertAll(listComposant);
      gammeDao.insertAll(listGamme);
      moduleDao.insertAll(listModule);
      moduleComposantDao.insertAll(listModuleComposant);
    } else {
      log.e("Erreur lors de la synchronisation des données");
    }
    //TODO Renvoyer un message d'erreur
  }

  void synchroData() async {
    UtilisateurData utilisateurData = await utilisateurDao.getUser();
    var utilisateurId = utilisateurData.utilisateurId;
    var token = utilisateurData.token;
    var response;

    final url = urlSynchroData + '/$utilisateurId';
    try {
      response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log.e("Erreur lors de la synchronisation des données");
    }
    if (response.statusCode == 200) {
      print('OK');
    }
  }
}
