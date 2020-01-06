import 'dart:core';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/produit_with_module.dart';
import 'package:proto_madera_front/data/models/projet_with_all_infos.dart';
import 'package:proto_madera_front/data/models/quote_creation_model.dart';
import 'package:proto_madera_front/data/models/quote_model.dart';

///
/// Provider to handle user input inside quote creation module
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderProjet with ChangeNotifier {
  String produitNom;
  String projetNom;
  QuoteCreationModel _quoteCreationValues;
  QuoteModel _quoteValues;
  int _editModuleIndex;
  int _editProductIndex;
  List<QuoteModel> productList;
  bool canInit = true;

  ProjetWithAllInfos projetWithAllInfos;
  ProjetData projet;
  List<ProduitWithModule> listProduitWithModule;
  ClientData client;

  //Produits
  ProduitData produitCourant;

  static DateTime dateProjet = DateTime.now();

  List<ProduitModuleData> listProduitModuleProjet;
  ModuleData moduleChoice;
  ProduitWithModule produitWithModule;
  ProduitModuleData moduleAdd;

  final Logger log = Logger();
  String dateNow = dateProjet.year.toString() +
      '/' +
      dateProjet.month.toString() +
      '/' +
      dateProjet.day.toString();

  void initAndHold() {
    //TODO Appeler cette méthode à chaque fois qu'on fait une redirection vers QuoteCreation
    if (canInit)
      init();
    else
      log.e('Can' 't init a new project, save first');
  }

  void validate(bool saveIt) {
    if (saveIt) {
      log.i('Saving project with following values...');
      log.i(_quoteCreationValues);
      productList.forEach((quoteModel) => log.i(quoteModel));
      canInit = true;
    } else
      canInit = true;
  }

  void init() {
    listProduitModuleProjet = new List();
    listProduitWithModule = new List();
    log.i('init called');
    canInit = false;
    productList = [];
    initProductCreationModel();
  }

  void deleteProductCreationModel(int productID) {
    productList.removeAt(productID);
    notifyListeners();
  }

  void loadProductCreationModel(int index) {
    _quoteValues = productList[index];
    _editProductIndex = index;
    notifyListeners();
  }

  void initProductCreationModel() {
    //TODO modifier ici
    _quoteValues = QuoteModel(
        gamme: null,
        nomDeProduit: null,
        //TODO listeModele a suppr
        listeModele: {'Modèle Premium n°1': null, 'Modèle Premium n°2': null},
        listeModule: Map<String, dynamic>(),
        modeleChoisi: null);
    productList.add(_quoteValues);
    _editProductIndex = productList.indexOf(_quoteValues);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void flush() {
    //TODO Enregistrer la configuration actuelle du devis en BDD
    canInit = true;
    initAndHold();
  }

  QuoteModel get quoteValues => _quoteValues;

  set editModuleIndex(int index) {
    _editModuleIndex = index;
    notifyListeners();
  }

  int get editModuleIndex => _editModuleIndex;

  int get editProductIndex => _editProductIndex;

  set dateCreation(String newDate) {
    _quoteCreationValues.dateDeCreation = newDate;
    notifyListeners();
  }

  String get dateCreation => _quoteCreationValues.dateDeCreation.toString();

  set refProjet(String refProjet) {
    _quoteCreationValues.refProjet = refProjet;
    notifyListeners();
  }

  String get refProjet => _quoteCreationValues.refProjet;

  void setDescription(String desc) {
    _quoteCreationValues.descriptionProjet = desc;
    notifyListeners();
  }

  String get description => _quoteCreationValues.descriptionProjet;

  String get nomDeProduit => _quoteValues.nomDeProduit;

  void setGamme(String nomGamme) {
    _quoteValues.gamme = nomGamme;
    notifyListeners();
  }

  String get gamme => _quoteValues.gamme;

  void setModel(String nomModel) {
    _quoteValues.modeleChoisi = nomModel;
    notifyListeners();
  }

  String get model => _quoteValues.modeleChoisi;

  void updateModuleInfos(
      String nomModule, String angle, String longueur1, String longueur2) {
    if (moduleChoice != null) {
      Map<String, Object> sections;
      if (angle == 'Entrant' || angle == 'Sortant') {
        sections = {
          'sections': [
            {'longueur': int.parse(longueur1)},
            {'longueur': int.parse(longueur2)}
          ]
        };
      } else {
        sections = {
          'sections': [
            {'longueur': int.parse(longueur1)}
          ]
        };
      }
      //La valeur -1 signifie qu'il n'est pas enregistrée en bdd
      moduleAdd = new ProduitModuleData(
        projetModuleId: -1,
        produitId: -1,
        produitModuleNom: nomModule,
        moduleId: moduleChoice.moduleId,
        produitModuleAngle: angle,
        produitModuleSectionLongueur: sections.toString(),
      );
      print(moduleAdd);
    }
  }

  Map<String, dynamic> get productModules => _quoteValues.listeModule;

  Map<String, dynamic> get modeleList => _quoteValues.listeModele;

  void logQC() {
    log.i('QuoteCreation values:\n$_quoteCreationValues');
  }

  void logQ() {
    log.i('Quote values:\n${_quoteValues.toString()}');
  }

  bool isFilled(String pageName) {
    switch (pageName) {
      case 'QuoteCreation':
        return (client != null && projetNom != null);
        break;
      case 'ProductCreation':
        return (produitNom != null);
        break;
      case 'AddModule':
        return (productModules.values
            .elementAt(editModuleIndex)['nature']
            .isNotEmpty);
        break;
      default:
        return false;
        break;
    }
  }

  void updateModuleNature(String newValue) {
    productModules.values.elementAt(editModuleIndex)['nature'] = newValue;
    notifyListeners();
  }

  ///Ajoute les produitsModules chargés a la liste des produitsModules du projet
  void initListProduitModuleProjet(List<ProduitModuleData> listProduitModule) {
    if (listProduitModule != null) {
      listProduitModule.forEach(
        (produitModule) => {
          listProduitModuleProjet.add(produitModule),
        },
      );
      notifyListeners();
    }
  }

  void resetListProduitModuleProjet(List<ProduitModuleData> listProduitModule) {
    if (listProduitModule != null && listProduitModuleProjet != null) {
      listProduitModule.forEach(
          (produitModule) => listProduitModuleProjet.remove(produitModule));
    }
    notifyListeners();
  }

  void setFinitions(String choice) {
    productModules.values
        .elementAt(editModuleIndex)
        .addAll({'finitions': choice});
  }

  void addModuleToListProduitModuleProjet() {
    listProduitModuleProjet.add(moduleAdd);
    notifyListeners();
  }

  void initClient(
      String nom, String prenom, String mailClient, String telClient) {
    client = new ClientData(
        id: -1, nom: nom, prenom: prenom, mail: mailClient, numTel: telClient);
  }

  void initClientWithClient(ClientData client) {
    this.client = client;
    notifyListeners();
  }

  void initProjet() {
    //TODO ajouter un champ description en bdd ?
    projet = new ProjetData(
      projetId: -1,
      nomProjet: projetNom,
      refProjet: projetNom + '-' + dateNow,
      dateProjet: dateProjet,
      devisEtatId: 2,
      clientId: client.id,
      prixTotal: 0.0,
    );
    notifyListeners();
  }

  void initProduitWithModule(String produitNom, int gammesId) {
    produitWithModule = ProduitWithModule(
        ProduitData(
            produitId: -1,
            produitNom: produitNom,
            gammesId: gammesId,
            prixProduit: 0.0,
            modele: false),
        listProduitModuleProjet);
    listProduitWithModule.add(produitWithModule);
    notifyListeners();
  }

  void initProjetWithAllInfos() {
    projetWithAllInfos = ProjetWithAllInfos(projet, listProduitWithModule);
    notifyListeners();
  }
}
