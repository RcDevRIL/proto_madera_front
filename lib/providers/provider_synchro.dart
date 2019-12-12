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
  DevisEtatDao devisEtatDao = new DevisEtatDao(db);
  ClientDao clientDao = new ClientDao(db);
  ClientAdresseDao clientAdresseDao = new ClientAdresseDao(db);
  AdresseDao adresseDao = new AdresseDao(db);
  ProjetDao projetDao = new ProjetDao(db);
  ProjetModuleDao projetModuleDao = new ProjetModuleDao(db);

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

      List<DevisEtatData> listDevisEtat = (data['devisEtat'] as List)
          .map((e) => DevisEtatData.fromJson(e))
          .toList();

      //TODO Supprimer le contenu des tables à chaque synchro ?
      //Insertion des données en base
      await composantDao.insertAll(listComposant);
      await gammeDao.insertAll(listGamme);
      await moduleDao.insertAll(listModule);
      await moduleComposantDao.insertAll(listModuleComposant);
      await devisEtatDao.insertAll(listDevisEtat);
    } else {
      log.e("Erreur lors de la synchronisation des données (referentiel)");
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
      var data = jsonDecode(response.body);
      List<ClientData> listClient =
          (data['client'] as List).map((f) => ClientData.fromJson(f)).toList();
      List<ClientAdresseData> listClientAdresse =
          (data['clientAdresse'] as List)
              .map((g) => ClientAdresseData.fromJson(g))
              .toList();

      List<AdresseData> listAdresse = (data['adresse'] as List)
          .map((h) => AdresseData.fromJson(h))
          .toList();

      List<ProjetData> listProjet = (data['projet'] as List)
          .map(
            (i) => i
              ..update(
                'dateProjet',
                (k) => DateTime.parse(k).millisecondsSinceEpoch,
              ),
          )
          .map((i) => ProjetData.fromJson(i))
          .toList();

      List<ProjetModuleData> listProjetModule = (data['projetModule'] as List)
          .map((j) => ProjetModuleData.fromJson(j))
          .toList();

      await clientDao.insertAll(listClient);
      await clientAdresseDao.insertAll(listClientAdresse);
      await adresseDao.insertAll(listAdresse);
      await projetDao.insertAll(listProjet);
      await projetModuleDao.insertAll(listProjetModule);
    } else {
      log.e("Erreur lors de la synchronisation des données (data)");
    }
    //TODO Renvoyer message d'erreur ?
  }
}
