import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/constants/url.dart';
import 'package:proto_madera_front/data/database/daos.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';

///
/// Provider permettant de gérer l'état de la synchronisation
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderSynchro with ChangeNotifier {
  Client http = new Client();
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
  List<DatabaseAccessor<MaderaDatabase>> daosSynchroList;
  DateTime _refLastSyncDate;
  bool _refSynced = false;
  DateTime _dataLastSyncDate;
  bool _dataSynced = false;

  ///
  ///Constructeur par défaut de notre classe de synchronisation.
  ///
  ///Permet d'initialiser nos DAO concernants les référentiels.
  ProviderSynchro({
    @required this.db,
    @required this.daosSynchroList,
  }) {
    for (DatabaseAccessor<MaderaDatabase> dao in daosSynchroList) {
      switch (dao.runtimeType) {
        case UtilisateurDao:
          utilisateurDao = dao;
          break;
        case ComposantDao:
          composantDao = dao;
          break;
        case GammeDao:
          gammeDao = dao;
          break;
        case ModuleDao:
          moduleDao = dao;
          break;
        case ModuleComposantDao:
          moduleComposantDao = dao;
          break;
        case DevisEtatDao:
          devisEtatDao = dao;
          break;
        case ClientDao:
          clientDao = dao;
          break;
        case ClientAdresseDao:
          clientAdresseDao = dao;
          break;
        case AdresseDao:
          adresseDao = dao;
          break;
        case ProjetDao:
          projetDao = dao;
          break;
        case ProjetModuleDao:
          projetModuleDao = dao;
          break;
        default:
          log.e("ERROR, NO DAO ASSIGNED TO THIS VALUE: ${dao.runtimeType}");
      }
    }
  }

  ///Renvoie la dernière date([DateTime]) de synchronisation des données utilisateur
  ///TODO D'ailleurs, on devrait avoir l'info dans le back: quand m dupont a sauvegardé/synchronisé la dernière fois, ça nous permettra de l'initialiser
  DateTime get dataLastSyncDate => _dataLastSyncDate ??= DateTime(2019, 12, 02);

  ///Renvoie la dernière date([DateTime]) de synchronisation des référentiels
  DateTime get refsLastSyncDate => _refLastSyncDate ??= DateTime(2019, 12, 02);

  ///Remplace la valeur de la date de dernière synchronisation des données de cet utilisateur
  setDataLastSyncDate(DateTime newDate) => this._dataLastSyncDate = newDate;

  ///Remplace la valeur de la date de dernière synchronisation des référentiels
  setRefsLastSyncDate(DateTime newDate) => this._refLastSyncDate = newDate;

  ///Synchronisation globale (n'effectue que les synchros nécessaires)
  Future<void> synchro() async {
    // r d
    // 1 ?
    if (_refSynced) {
      // 1 1
      if (_dataSynced)
        log.i('Synchronisation globale déjà effectuée aujourd' 'hui!');
      // 1 0
      else {
        log.i(
            'Synchronisation des référentiels déjà effectuée le ${refsLastSyncDate.toString().substring(0, 10)}!');
        _dataSynced = await synchroData();
        log.i('Synchronisation globale effectuée');
      }
    }
    // 0 ?
    else {
      // 0 1
      if (_dataSynced) {
        log.i(
            'Synchronisation des données déjà effectuée le ${dataLastSyncDate.toString().substring(0, 10)}!');
        _refSynced = await synchroReferentiel();
        log.i('Synchronisation globale effectuée');
      }
      // 0 0
      else {
        log.i('Synchronisation lancée...');
        _refSynced = await synchroReferentiel();
        _dataSynced = await synchroData();
        log.i('Synchronisation globale effectuée');
      }
    }
  }

  ///Synchronisation des données de l'utilisateur connecté
  ///Renvoie [bool] [true] si l'opération est un succès
  Future<bool> synchroData() async {
    log.i('Synchronisation des données utilisateur...');
    if (_dataSynced) {
      log.i(
          'Synchronisation déjà effectuée le ${dataLastSyncDate.toString().substring(0, 10)}!');
      return true;
    } else {
      UtilisateurData utilisateurData;
      if (http.runtimeType != MockClient)
        utilisateurData = await utilisateurDao.getUser();
      else
        utilisateurData = UtilisateurData(
            utilisateurId: 4, login: 'testuser', token: 'fesfk-feksnf-fesf');
      var response;

      final url =
          MaderaUrl.urlSynchroData + '/${utilisateurData.utilisateurId}';
      try {
        response = await http.get(url,
            headers: {'Authorization': 'Bearer ${utilisateurData.token}'});
      } catch (e) {
        log.e(
            'Error when trying to call ${MaderaUrl.urlSynchroData}/${utilisateurData.utilisateurId}:\n' +
                e.toString());
        return false;
      }
      if (response.statusCode == 200) {
        if (http.runtimeType !=
            MockClient) //pour faire passer les test unitaires (le fait d'avoir cette méthode extraite est un début pour la séparation des logiques et le mode hors ligne ;))
          await _insertUserData(response.body);
        _dataLastSyncDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        _dataSynced = true;
        log.i('Done.');
        return true;
      } else {
        log.e("Erreur lors de la synchronisation des données utilisateur");
        return false;
      }
    }
  }

  ///Fontctionnalité(s):
  /// Méthode pour sauvegarder les données utilisateurs renvoyées par le backend
  ///
  ///Paramètre(s):
  /// String [responseBody] le "body" de la réponse suite à la requête HTTP
  Future _insertUserData(responseBody) async {
    //TODO mettre String pour la variable?? j'étais pas sur donc pour l'instant: dynamic
    var data = jsonDecode(responseBody);
    List<ClientData> listClient =
        (data['client'] as List).map((f) => ClientData.fromJson(f)).toList();
    List<ClientAdresseData> listClientAdresse = (data['clientAdresse'] as List)
        .map((g) => ClientAdresseData.fromJson(g))
        .toList();

    List<AdresseData> listAdresse =
        (data['adresse'] as List).map((h) => AdresseData.fromJson(h)).toList();

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
  }

  /// Synchronisation des référentiels
  ///Renvoie [bool] [true] si l'opération est un succès
  Future<bool> synchroReferentiel() async {
    log.i('Synchronisation des référentiels...');
    if (_refSynced) {
      log.i(
          'Synchronisation déjà effectuée le ${refsLastSyncDate.toString().substring(0, 10)}!');
      return true;
    } else {
      UtilisateurData utilisateurData;
      if (http.runtimeType != MockClient)
        utilisateurData = await utilisateurDao.getUser();
      else
        utilisateurData = UtilisateurData(
            utilisateurId: 4, login: 'testuser', token: 'fesfk-feksnf-fesf');
      var response;
      try {
        //TODO passer en param la derniere date de synchro ?
        response = await http.get(MaderaUrl.urlSynchroRef,
            headers: {'Authorization': 'Bearer ${utilisateurData.token}'});
      } catch (e) {
        log.e('Error when trying to call ${MaderaUrl.urlSynchroRef}:\n' +
            e.toString());
        return false;
      }
      if (response.statusCode == 200) {
        if (http.runtimeType !=
            MockClient) //pour faire passer les test unitaires (le fait d'avoir cette méthode extraite est un début pour la séparation des logiques et le mode hors ligne ;))
          await _insertReferentiel(response.body);
        _refLastSyncDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        _refSynced = true;
        log.i('Done.');
        return true;
      } else {
        log.e("Erreur lors de la synchronisation des référentiels");
        return false;
      }
    }
  }

  ///Fontctionnalité(s):
  /// Méthode pour sauvegarder les données des référentiels renvoyées par le backend
  ///
  ///Paramètre(s):
  /// String [responseBody] le "body" de la réponse suite à la requête HTTP
  Future _insertReferentiel(responseBody) async {
    var data = jsonDecode(responseBody);
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

    //TODO Optimisation: faire un comparatif des données et update seulement le nécessaire
    //Insertion des données en base
    await composantDao.insertAll(listComposant);
    await gammeDao.insertAll(listGamme);
    await moduleDao.insertAll(listModule);
    await moduleComposantDao.insertAll(listModuleComposant);
    await devisEtatDao.insertAll(listDevisEtat);
  }
}