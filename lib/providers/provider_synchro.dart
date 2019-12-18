import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'package:proto_madera_front/constants/url.dart';
import 'package:proto_madera_front/database/daos.dart';
import 'package:proto_madera_front/database/madera_database.dart';

///
/// Provider permettant de gérer l'état de la synchronisation
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class ProviderSynchro with ChangeNotifier {
  //TODO A revoir, faut que je regarde au travail
  final log = Logger();
  MaderaDatabase db;
  UtilisateurDao utilisateurDao;
  ComposantDao composantDao;
  GammeDao gammeDao;
  ModuleDao moduleDao;
  ModuleComposantDao moduleComposantDao;
  DevisEtatDao devisEtatDao;
  ClientDao clientDao;
  ClientAdresseDao clientAdresseDao;
  AdresseDao adresseDao;
  ProjetDao projetDao;
  ProjetModuleDao projetModuleDao;
  String _refLastSyncDate;
  String _dataLastSyncDate;

  String get refsLastSyncDate => _refLastSyncDate ??= '2019-12-02';

  setRefsLastSyncDate(String newDate) => this._refLastSyncDate = newDate;

  String get dataLastSyncDate => _dataLastSyncDate ??= '2019-12-02';

  setDataLastSyncDate(String newDate) => this._dataLastSyncDate = newDate;

  ProviderSynchro({@required this.db}) {
    utilisateurDao = new UtilisateurDao(db);
    composantDao = new ComposantDao(db);
    gammeDao = new GammeDao(db);
    moduleDao = new ModuleDao(db);
    moduleComposantDao = new ModuleComposantDao(db);
    devisEtatDao = new DevisEtatDao(db);
    clientDao = new ClientDao(db);
    clientAdresseDao = new ClientAdresseDao(db);
    adresseDao = new AdresseDao(db);
    projetDao = new ProjetDao(db);
    projetModuleDao = new ProjetModuleDao(db);
  }

  void synchro() {
    synchroReferentiel();
    synchroData();
  }

  //Synchro referentiel
  Future<bool> synchroReferentiel() async {
    log.i('Synchronisation des référentiels...');
    UtilisateurData utilisateurData = await utilisateurDao.getUser();
    String token = utilisateurData.token;
    var response;
    try {
      //TODO passer en param la derniere date de synchro ?
      response = await http.get(MaderaUrl.urlSynchroRef,
          headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log.e('Error when trying to call ${MaderaUrl.urlSynchroRef}:\n' +
          e.toString());
      return false;
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
      log.i('OLD sync date: $refsLastSyncDate');
      setRefsLastSyncDate(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString());
      log.i('NEW sync date: $refsLastSyncDate');
      log.i('Done.');
      return true;
    } else {
      log.e("Erreur lors de la synchronisation des référentiels");
      return false;
    }
    //TODO Renvoyer un message d'erreur
  }

  Future<bool> synchroData() async {
    log.i('Synchronisation des données utilisateur...');
    UtilisateurData utilisateurData = await utilisateurDao.getUser();
    var utilisateurId = utilisateurData.utilisateurId;
    var token = utilisateurData.token;
    var response;

    final url = MaderaUrl.urlSynchroData + '/$utilisateurId';
    try {
      response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      log.e(
          'Error when trying to call ${MaderaUrl.urlSynchroData}/$utilisateurId:\n' +
              e.toString());
      return false;
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
      log.i('OLD sync date: $refsLastSyncDate');
      setDataLastSyncDate(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString());
      log.i('NEW sync date: $refsLastSyncDate');
      log.i('Done.');
      return true;
    } else {
      log.e("Erreur lors de la synchronisation des données utilisateur");
      return false;
    }
  }
}
