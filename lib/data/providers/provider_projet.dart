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
  String _moduleNom;
  String _moduleSection;
  String _moduleSection2;
  String _moduleAngle;
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
    _produitNom = '';
    notifyListeners();
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

  QuoteModel get quoteValues => _quoteValues;

  set editModuleIndex(int index) {
    _editModuleIndex = index;
    notifyListeners();
  }

  int get editModuleIndex => _editModuleIndex;

  set moduleAngle(String angle) {
    (angle.contains(RegExp('[eE]ntrant')) ||
            angle.contains(RegExp('[sS]ortant')))
        ? _moduleAngle = angle
        : _moduleAngle = '';
    notifyListeners();
  }

  String get moduleAngle => _moduleAngle;

  set moduleNom(String nom) {
    _moduleNom = nom;
    notifyListeners();
  }

  String get moduleNom => _moduleNom;

  set moduleSection(String section) {
    _moduleSection = section;
    notifyListeners();
  }

  String get moduleSection => _moduleSection;

  set moduleSection2(String section) {
    _moduleSection2 = section;
    notifyListeners();
  }

  String get moduleSection2 => _moduleSection2;

  set editProductIndex(int index) {
    _editProductIndex = index;
    notifyListeners();
  }

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

  void initModuleInfos() {
    _moduleAngle = '';
    _moduleSection = '';
    _moduleSection2 = '';
    _moduleNom = '';
  }

  void loadModuleInfos(int index) {
    moduleAdd = _listProduitModuleProjet.elementAt(index);
    _moduleNom = moduleAdd.produitModuleNom;
    _moduleAngle = moduleAdd.produitModuleAngle;
    if (_moduleAngle.contains(RegExp('[eE]ntrant')) ||
        _moduleAngle.contains(RegExp('[sS]ortant'))) {
      _moduleSection = moduleAdd.produitModuleSectionLongueur
          .trim()
          .split('[')[1]
          .split(':')[1]
          .split('}')[0];
      _moduleSection2 = moduleAdd.produitModuleSectionLongueur
          .trim()
          .split('[')[1]
          .split(':')[2]
          .split('}')[0];
    } else {
      _moduleSection = _moduleSection = moduleAdd.produitModuleSectionLongueur
          .trim()
          .split('[')[1]
          .split(':')[1]
          .split('}')[0];
      _moduleSection2 = '';
    }
  }

  void updateModuleInfos() {
    if (editModuleIndex != _listProduitModuleProjet.length) {
      //Edition
      if (moduleAdd.moduleId != null) {
        Map<String, Object> sections;
        if (_moduleAngle.isNotEmpty) {
          sections = {
            'sections': [
              {'longueur': int.parse(_moduleSection)},
              {'longueur': int.parse(_moduleSection2)}
            ]
          };
        } else {
          sections = {
            'sections': [
              {'longueur': int.parse(_moduleSection)}
            ]
          };
        }
        moduleAdd = moduleAdd.copyWith(
          produitModuleNom: _moduleNom,
          produitModuleAngle: _moduleAngle,
          produitModuleSectionLongueur: sections.toString(),
        );
      } else
        log.e('ERROR NO MODEL??? WTF IS HAPPENING!!');
    } else {
      //Création
      if (moduleChoice != null) {
        Map<String, Object> sections;
        if (_moduleAngle.isNotEmpty) {
          sections = {
            'sections': [
              {'longueur': int.parse(_moduleSection)},
              {'longueur': int.parse(_moduleSection2)}
            ]
          };
        } else {
          sections = {
            'sections': [
              {'longueur': int.parse(_moduleSection)}
            ]
          };
        }
        //La valeur -1 signifie qu'il n'est pas enregistrée en bdd
        moduleAdd = new ProduitModuleData(
          projetModuleId: -1,
          produitId: -1,
          produitModuleNom: _moduleNom,
          moduleId: moduleChoice.moduleId,
          produitModuleAngle: _moduleAngle,
          produitModuleSectionLongueur: sections.toString(),
        );
        print(moduleAdd);
      } else
        log.e('Please select a model');
    }
  }

  List<ProduitModuleData> get produitModules => _listProduitModuleProjet;

  void logQC() {
    projet != null
        ? log.i('QuoteCreation values:\n$projet')
        : log.e('Please create the project...');
  }

  void logQ() {
    _listProduitModuleProjet != null
        ? _listProduitModuleProjet.forEach((p) => log.i(p))
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
            _listProduitModuleProjet.length != 0);
        break;
      case 'AddModule':
        {
          if (_editModuleIndex == _listProduitModuleProjet.length)
            return moduleChoice != null &&
                (_moduleNom.isNotEmpty &&
                    _moduleSection.isNotEmpty &&
                    !(_moduleAngle.isNotEmpty ^ _moduleSection2.isNotEmpty));
          return (_moduleNom.isNotEmpty &&
              _moduleSection.isNotEmpty &&
              !(_moduleAngle.isNotEmpty ^ _moduleSection2.isNotEmpty));
        }
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
      log.e(
          'ERROR in resetListProduitModuleProjet()! First time calling it for this product ? If so, ignore.');
  }

  void setFinitions(String choice) {}

  void updateListProduitModuleProjet() {
    if (_editModuleIndex == _listProduitModuleProjet.length)
      _listProduitModuleProjet.add(moduleAdd);
    else {
      //update du module
      _listProduitModuleProjet.removeAt(_editModuleIndex);
      _listProduitModuleProjet.insert(_editModuleIndex, moduleAdd);
    }
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
    notifyListeners();
  }

  void initProjetWithAllInfos() {
    projetWithAllInfos = ProjetWithAllInfos(projet, listProduitProjet);
    notifyListeners();
  }

  void updateListProduitProjet() {
    if (_editProductIndex != listProduitProjet.length) {
      listProduitProjet.removeAt(_editProductIndex);
      listProduitProjet.insert(_editProductIndex, produitWithModule);
    } else {
      listProduitProjet.add(produitWithModule);
    }
    notifyListeners();
  }
}
