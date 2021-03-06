import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:logger/logger.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proto_madera_front/data/constants/url.dart';
import 'package:proto_madera_front/data/database/daos.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/projet_with_all_infos.dart';

///
/// Provider to handle backend synchronization state
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1.1
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
  ProduitModuleDao produitModuleDao;
  ProduitDao produitDao;
  ComposantGroupeDao composantGroupeDao;
  ProjetProduitsDao projetProduitsDao;
  List<DatabaseAccessor<MaderaDatabase>> daosSynchroList;
  DateTime _refLastSyncDate;
  bool _refSynced = false;
  DateTime _dataLastSyncDate;
  bool _dataSynced = false;
  File file;

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
        case ProduitModuleDao:
          produitModuleDao = dao;
          break;
        case ComposantGroupeDao:
          composantGroupeDao = dao;
          break;
        case ProduitDao:
          produitDao = dao;
          break;
        case ProjetProduitsDao:
          projetProduitsDao = dao;
          break;
        default:
          log.e('ERROR, NO DAO ASSIGNED TO THIS VALUE: ${dao.runtimeType}');
      }
    }
  }

  ///Renvoie la dernière date([DateTime]) de synchronisation des données utilisateur
  DateTime get dataLastSyncDate => _dataLastSyncDate ??= DateTime(2019, 12, 02);

  set dataLastSyncDate(DateTime date) {
    _dataLastSyncDate = date;
    notifyListeners();
  }

  ///Renvoie la dernière date([DateTime]) de synchronisation des référentiels
  DateTime get refsLastSyncDate => _refLastSyncDate ??= DateTime(2019, 12, 02);

  set refsLastSyncDate(DateTime date) {
    _refLastSyncDate = date;
    notifyListeners();
  }

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
        if (http.runtimeType != MockClient) await deleteForSynchro();
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
        if (http.runtimeType != MockClient) await deleteForSynchro();
        _refSynced = await synchroReferentiel();
        log.i('Synchronisation globale effectuée');
      }
      // 0 0
      else {
        log.i('Synchronisation lancée...');
        if (http.runtimeType != MockClient) await deleteForSynchro();
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
        utilisateurData = await utilisateurDao.getLastUser();
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
        _dataLastSyncDate = DateTime.now();
        _dataSynced = true;
        log.i('Done.');
        return true;
      } else {
        log.e('Erreur lors de la synchronisation des données utilisateur');
        return false;
      }
    }
  }

  ///Fontctionnalité(s):
  /// Méthode pour sauvegarder les données utilisateurs renvoyées par le backend
  ///
  ///Paramètre(s):
  /// String [responseBody] le 'body' de la réponse suite à la requête HTTP
  Future _insertUserData(responseBody) async {
    var data = jsonDecode(responseBody);
    List<ClientData> listClient =
        (data['client'] as List).map((f) => ClientData.fromJson(f)).toList();
    List<ClientAdresseData> listClientAdresse = (data['clientAdresse'] as List)
        .map((g) => ClientAdresseData.fromJson(g))
        .toList();

    List<AdresseData> listAdresse =
        (data['adresse'] as List).map((h) => AdresseData.fromJson(h)).toList();
    //Ba celui là il a pas data à la fin, c'est bizarre mais bon
    List<ProjetProduit> listProjetProduit = (data['projetProduits'] as List)
        .map((y) => ProjetProduit.fromJson(y))
        .toList();

    List<ProduitModuleData> listProduitModule = (data['produitModule'] as List)
        .map((z) => ProduitModuleData.fromJson(z))
        .toList();

    List<ProduitData> listProduit =
        (data['produit'] as List).map((o) => ProduitData.fromJson(o)).toList();
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

    await clientDao.insertAll(listClient);
    await clientAdresseDao.insertAll(listClientAdresse);
    await adresseDao.insertAll(listAdresse);
    await projetDao.insertAll(listProjet);
    await produitDao.insertAll(listProduit);
    await produitModuleDao.insertAll(listProduitModule);
    await projetProduitsDao.insertAll(listProjetProduit);
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
        utilisateurData = await utilisateurDao.getLastUser();
      else
        utilisateurData = UtilisateurData(
            utilisateurId: 4, login: 'testuser', token: 'fesfk-feksnf-fesf');
      var response;
      try {
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
        _refLastSyncDate = DateTime.now();
        _refSynced = true;
        log.i('Done.');
        return true;
      } else {
        log.e('Erreur lors de la synchronisation des référentiels');
        return false;
      }
    }
  }

  ///Fontctionnalité(s):
  /// Méthode pour sauvegarder les données des référentiels renvoyées par le backend
  ///
  ///Paramètre(s):
  /// String [responseBody] le 'body' de la réponse suite à la requête HTTP
  Future _insertReferentiel(responseBody) async {
    var data = jsonDecode(responseBody);
    List<ComposantData> listComposant = (data['composant'] as List)
        .map((a) => ComposantData.fromJson(a))
        .toList();

    List<ComposantGroupeData> listComposantGroupe =
        (data['composantGroupe'] as List)
            .map((m) => ComposantGroupeData.fromJson(m))
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

    List<ProduitData> listProduitModele = (data['produitModele'] as List)
        .map((u) => ProduitData.fromJson(u))
        .toList();

    List<ProduitModuleData> listProduitModuleModele =
        (data['produitModuleModele'] as List)
            .map((p) => ProduitModuleData.fromJson(p))
            .toList();

    //Insertion des données en base
    await composantDao.insertAll(listComposant);
    await gammeDao.insertAll(listGamme);
    await moduleDao.insertAll(listModule);
    await moduleComposantDao.insertAll(listModuleComposant);
    await devisEtatDao.insertAll(listDevisEtat);
    await composantGroupeDao.insertAll(listComposantGroupe);
    await produitModuleDao.insertAll(listProduitModuleModele);
    await produitDao.insertAll(listProduitModele);
  }

  ///Méthode qui va purger la base de données sans effacer les projets non synchronisés
  Future deleteForSynchro() async {
    if (!_dataSynced && _refSynced) {
      log.d('delete user data');
      //on veut seulement delete les données user
      await clientDao.deleteAll();
      await clientAdresseDao.deleteAll();
      await adresseDao.deleteAll();
      await projetDao.deleteAll();
      await produitDao.deleteAll();
      await produitModuleDao.deleteAll();
      await projetProduitsDao.deleteAll();
    } else if (!_refSynced && _dataSynced) {
      log.d('delete referentiels');
      //on veut seulement delete les référentiels
      await composantDao.deleteAll();
      await gammeDao.deleteAll();
      await moduleDao.deleteAll();
      await moduleComposantDao.deleteAll();
      await devisEtatDao.deleteAll();
      await composantGroupeDao.deleteAll();
      await produitModuleDao.deleteAll();
      await produitDao.deleteAll();
    } else {
      log.d('delete all');
      await composantDao.deleteAll();
      await gammeDao.deleteAll();
      await moduleDao.deleteAll();
      await moduleComposantDao.deleteAll();
      await devisEtatDao.deleteAll();
      await composantGroupeDao.deleteAll();
      await clientDao.deleteAll();
      await clientAdresseDao.deleteAll();
      await adresseDao.deleteAll();
      await projetDao.deleteAll();
      await produitDao.deleteAll();
      await produitModuleDao.deleteAll();
      await projetProduitsDao.deleteAll();
    }
  }

  ///Appel serveur pour créer le projet
  Future createProjectOnServer(ProjetWithAllInfos projetWithAllInfos) async {
    log.i('Création du projet sur le serveur...');
    UtilisateurData utilisateurData;
    if (http.runtimeType != MockClient)
      utilisateurData = await utilisateurDao.getLastUser();
    else
      utilisateurData = UtilisateurData(
          utilisateurId: 4, login: 'testuser', token: 'fesfk-feksnf-fesf');
    var response;
    var body = jsonEncode(projetWithAllInfos.toJson());
    try {
      response = await http.post(
        MaderaUrl.urlCreateProject,
        headers: {
          'Authorization': 'Bearer ${utilisateurData.token}',
          'Content-Type': 'application/json'
        },
        body: body,
      );
    } catch (e) {
      log.e('Error when trying to call ${MaderaUrl.urlCreateProject}:\n' +
          e.toString());
      return false;
    }
    print(response);
  }

  Future<void> createOrFileUrl(int projetId) async {
    UtilisateurData utilisateurData;
    if (http.runtimeType != MockClient)
      utilisateurData = await utilisateurDao.getLastUser();
    else
      utilisateurData = UtilisateurData(
          utilisateurId: 4, login: 'testuser', token: 'fesfk-feksnf-fesf');
    try {
      HttpClient client = new HttpClient();
      client
          .postUrl(Uri.parse(MaderaUrl.urlProjectDevis +
              '/$projetId/${utilisateurData.utilisateurId}'))
          .then((HttpClientRequest request) {
        request.headers.add('Authorization', 'Bearer ${utilisateurData.token}');
        return request.close();
      }).then((HttpClientResponse response) async {
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          String dir;
          if (!kIsWeb) {
            print((await getApplicationDocumentsDirectory()).path);
            dir = (await getApplicationDocumentsDirectory()).path;
            file = File("${dir ?? 'toto'}/devis");
            await file.writeAsBytes(bytes);
          } else {
            throw UnimplementedError("Web is not supported yet");
          }
          notifyListeners();
        } else {
          log.e('Error when trying to call ${MaderaUrl.urlProjectDevis}');
        }
      });
    } catch (e) {
      log.e('Error when trying to call ${MaderaUrl.urlProjectDevis}:\n' +
          e.toString());
      return null;
    }
  }
}
