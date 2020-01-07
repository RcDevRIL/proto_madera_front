import 'dart:core';
import 'dart:math';

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
  String _produitNom;
  String _projetNom;
  String _projetDesc;
  GammeData _produitGamme;
  ProduitData _produitModele;
  QuoteCreationModel _quoteCreationValues;
  QuoteModel _quoteValues;
  int _editModuleIndex;
  int _editProductIndex;
  List<ProjetData> productList;
  bool canInit = true;

  ProjetWithAllInfos projetWithAllInfos;
  ProjetData projet;
  List<ProduitWithModule> listProduitProjet;
  ClientData client;

  //Produits
  ProduitData produitCourant;

  static final DateTime _dateProjet = DateTime.now();
  static final String _dateNow = _dateProjet.year.toString() +
      '/' +
      _dateProjet.month.toString() +
      '/' +
      _dateProjet.day.toString();

  List<ProduitModuleData> _listProduitModuleProjet;
  ModuleData moduleChoice;
  ProduitWithModule produitWithModule;
  ProduitModuleData moduleAdd;

  final Logger log = Logger();

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
      logQC();
      logQ();
      canInit = true;
    } else
      canInit = true;
  }

  void init() {
    log.i('init called');
    canInit = false;
    _editModuleIndex = 0;
    _editProductIndex = 0;
    _listProduitModuleProjet = new List();
    listProduitProjet = new List();
    productList = [];
    client = null;
    _produitGamme = null;
    _produitModele = null;
    _projetNom = '';
    _projetDesc = '';
    initProductCreationModel();
  }

  void deleteProductCreationModel(int productID) {
    listProduitProjet.removeAt(productID);
    notifyListeners();
  }

  void loadProductCreationModel(int productIndex) {
    _editModuleIndex = 0;
    _editProductIndex = productIndex;
    _produitModele = null;
    _produitNom = listProduitProjet[_editProductIndex].produit.produitNom;
    _listProduitModuleProjet =
        listProduitProjet[_editProductIndex].listProduitModule;
    notifyListeners();
  }

  void initProductCreationModel() {
    _editModuleIndex = 0;
    _editProductIndex = 0;
    _produitGamme = null;
    _produitModele = null;
    _produitNom = '';
    _listProduitModuleProjet = List();
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

  String get dateNow => _dateNow;

  set refProjet(String refProjet) {
    _quoteCreationValues.refProjet = refProjet;
    notifyListeners();
  }

  String get refProjet => _quoteCreationValues.refProjet;

  void setDescription(String desc) {
    _projetDesc = desc;
    notifyListeners();
  }

  String get description => _projetDesc;

  void setProjetNom(String nom) {
    _projetNom = nom;
    notifyListeners();
  }

  String get projetNom => _projetNom;

  void setProduitNom(String nom) {
    _produitNom = nom;
    notifyListeners();
  }

  String get produitNom => _produitNom;

  set gamme(GammeData gammeChoisie) {
    _produitGamme = gammeChoisie;
    notifyListeners();
  }

  GammeData get gamme => _produitGamme;

  void setModele(ProduitData modeleChoisi) {
    _produitModele = modeleChoisi;
    notifyListeners();
  }

  ProduitData get modelProduit => _produitModele;

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

  List<ProduitModuleData> get produitModules => _listProduitModuleProjet;

  Map<String, dynamic> get modeleList => _quoteValues.listeModele;

  void logQC() {
    projet != null
        ? log.i('QuoteCreation values:\n$projet')
        : log.e('Please create the project...');
  }

  void logQ() {
    productList != null
        ? productList.forEach((p) => log.i(p))
        : log.e('ERROR: No product List created.');
  }

  bool isFilled(String pageName) {
    switch (pageName) {
      case 'QuoteCreation':
        return (client != null &&
            _projetNom.isNotEmpty &&
            _projetDesc.isNotEmpty);
        break;
      case 'ProductCreation':
        return (_produitNom.isNotEmpty &&
            gamme != null &&
            listProduitProjet.length != 0);
        break;
      case 'AddModule':
        return false;
        break;
      default:
        return false;
        break;
    }
  }

  void updateModuleNature(String newValue) {
    _quoteValues.listeModule.values.elementAt(editModuleIndex)['nature'] =
        newValue;
    notifyListeners();
  }

  ///Ajoute les produitsModules chargés a la liste des produitsModules du projet
  void initListProduitModuleProjet(List<ProduitModuleData> listProduitModule) {
    if (listProduitModule != null) {
      listProduitModule.forEach(
        (produitModule) => {
          _listProduitModuleProjet.add(produitModule),
        },
      );
      notifyListeners();
    } else
      log.e('Error in initListProduitModuleProjet()!');
  }

  ///Supprime les produitsModules du modèle de produit tout en gardant ceux ajoutés par l'utilisateur
  void resetListProduitModuleProjet(List<ProduitModuleData> listProduitModule) {
    if (listProduitModule != null && _listProduitModuleProjet != null) {
      listProduitModule.forEach(
          (produitModule) => _listProduitModuleProjet.remove(produitModule));
      _produitModele = null;
      notifyListeners();
    } else
      log.e('ERROR in resetListProduitModuleProjet()!');
  }

  void setFinitions(String choice) {
    _quoteValues.listeModule.values
        .elementAt(editModuleIndex)
        .addAll({'finitions': choice});
  }

  void addModuleToListProduitModuleProjet() {
    _listProduitModuleProjet.add(moduleAdd);
    notifyListeners();
  }

  void initClientWithClient(ClientData client) {
    this.client = client;
    notifyListeners();
  }

  void initProjet() {
    //TODO ajouter un champ description en bdd ?
    var r = Random();
    int test = r.nextInt(
        539985); // valeur borne haute choisie au hasard, 2 chiffres par contributeurs
    projet = new ProjetData(
      projetId: -1,
      nomProjet: projetNom,
      refProjet: _dateNow.replaceAll('/', '') +
          '_' +
          client.id.toString() +
          '_' +
          test.toString(),
      dateProjet: _dateProjet,
      devisEtatId: 2,
      clientId: client.id,
      prixTotal: 0.0,
    );
    notifyListeners();
  }

  void initProduitWithModule() {
    produitWithModule = ProduitWithModule(
        ProduitData(
            produitId: -1,
            produitNom: produitNom,
            gammesId: _produitGamme.gammeId,
            prixProduit: 0.0,
            modele: false),
        _listProduitModuleProjet);
    listProduitProjet.add(produitWithModule);
    notifyListeners();
  }

  void initProjetWithAllInfos() {
    projetWithAllInfos = ProjetWithAllInfos(projet, listProduitProjet);
    notifyListeners();
  }
}
