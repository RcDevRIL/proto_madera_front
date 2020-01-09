import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/models.dart'
    show ProduitWithModule, ProjetWithAllInfos;

///
/// Provider to handle user input inside quote creation module
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderProjet with ChangeNotifier {
  /*
  * Variables pour la page QuoteCreation
  */
  ///Date précise du projet générée lorsque l'utilisateur arrive sur la page 'Informations Générales' ([QuoteCreation])
  static DateTime _dateProjet;

  ///Date du jour de la création du projet
  static final String _dateNow = _dateProjet.year.toString() +
      '/' +
      _dateProjet.month.toString() +
      '/' +
      _dateProjet.day.toString();

  ///Nom du projet
  String _projetNom;

  ///Description du projet
  String _projetDesc;

  ///Client assigné à ce projet
  ClientData _client;

  ///Saving structure
  ProjetData _projet;

  /*
  * Variables pour la page ProductCreation
  */
  String _produitNom;
  GammeData _produitGamme;
  ProduitData _produitModele;
  int _editProductIndex;
  List<ProduitModuleData> _listProduitModuleProjet;

  ///Saving structure
  ProduitWithModule _produitWithModule;

  /*
  * Variables pour les pages AddModule & Finishing
  */
  String _moduleNom;
  String _moduleSection;
  String _moduleSection2;
  String _moduleAngle;
  ModuleData _moduleChoice;
  int _editModuleIndex;

  ///Saving structure
  ProduitModuleData moduleAdd;

  ///ProductList Model
  List<ProduitWithModule> _listProduitProjet;

  ///Final Saving structure to send on our backend server or to on our local [MaderaDatabase]
  ProjetWithAllInfos projetWithAllInfos;

  ///Boolean used to avoid loosing data. Is true only after a call to validate()
  bool canInit = true;

  final Logger log = Logger();

  void logQC() {
    _projet != null
        ? log.i('QuoteCreation values:\n$_projet')
        : log.e('Please create the project...');
  }

  void logQ() {
    _listProduitModuleProjet != null
        ? _listProduitModuleProjet.forEach((p) => log.i(p))
        : log.e('ERROR: No product List created.');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initAndHold() {
    canInit ? init() : log.e('Can' 't init a new project, save first');
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
    _dateProjet = DateTime.now();
    _projetNom = '';
    _projetDesc = '';
    _client = null;
    _produitNom = '';
    _produitGamme = null;
    _produitModele = null;
    _editProductIndex = 0;
    _listProduitModuleProjet = new List();
    _moduleAngle = '';
    _moduleSection = '';
    _moduleSection2 = '';
    _moduleNom = '';
    _editModuleIndex = 0;
    _listProduitProjet = new List();
    notifyListeners();
  }

  bool isFilled(String pageName) {
    switch (pageName) {
      case 'QuoteCreation':
        return (_client != null &&
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
            //Création
            return _moduleChoice != null &&
                (_moduleNom.isNotEmpty &&
                    _moduleSection.isNotEmpty &&
                    !(_moduleAngle.isNotEmpty ^ _moduleSection2.isNotEmpty));
          else //Edition
            return (_moduleNom.isNotEmpty &&
                _moduleSection.isNotEmpty &&
                !(_moduleAngle.isNotEmpty ^ _moduleSection2.isNotEmpty));
        }
        break;
      //TODO
      case 'Finishings':
        return true;
        break;
      //TODO
      case 'ProductList':
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  void initProjet() {
    //TODO ajouter un champ description en bdd ?
    var r = Random();
    _projet = new ProjetData(
      projetId: -1,
      nomProjet: _projetNom,
      refProjet: _dateNow.replaceAll('/', '') +
          '_' +
          _client.id.toString() +
          '_' +
          r
              .nextInt(
                  539985) // valeur borne haute choisie au hasard, 2 chiffres par contributeurs
              .toString(),
      dateProjet: _dateProjet,
      devisEtatId: 2,
      clientId: _client.id,
      prixTotal: 0.0,
      isSynchro: false,
    );
    notifyListeners();
  }

  void initClientWithClient(ClientData client) {
    _client = client;
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

  void loadProductCreationModel(int productIndex) {
    _editModuleIndex = 0;
    _editProductIndex = productIndex;
    _produitModele = null;
    _produitNom = _listProduitProjet[_editProductIndex].produit.produitNom;
    _listProduitModuleProjet =
        _listProduitProjet[_editProductIndex].listProduitModule;
    notifyListeners();
  }

  void deleteProductCreationModel(int productID) {
    _listProduitProjet.removeAt(productID);
    notifyListeners();
  }

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
    // Si le module est défini avec un angle, alors on récupère les valeurs des deux sections
    // et on les affecte à la bonne variable
    if (_moduleAngle.isNotEmpty) {
      //TODO Vérifier si dans le jeu d'essai cette règle s'applique bien: pas d'angle => empty String
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
      //Sinon on sait qu'il n'y a qu'une seule section à récupérer
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
      if (_moduleChoice != null) {
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
          moduleId: _moduleChoice.moduleId,
          produitModuleAngle: _moduleAngle,
          produitModuleSectionLongueur: sections.toString(),
        );
        print(moduleAdd);
      } else
        log.e('Please select a model');
    }
  }

  void deleteModuleFromProduct() {
    _listProduitModuleProjet.removeAt(_editModuleIndex);
    notifyListeners();
  }

  ///Ajoute les produitsModules chargés a la liste des produitsModules du _projet
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

  void initProduitWithModule() {
    _produitWithModule = ProduitWithModule(
        ProduitData(
            produitId: -1,
            produitNom: produitNom,
            gammesId: _produitGamme.gammeId,
            prixProduit: 0.0,
            modele: false),
        _listProduitModuleProjet);
    notifyListeners();
  }

  void updateListProduitProjet() {
    if (_editProductIndex != _listProduitProjet.length) {
      _listProduitProjet.removeAt(_editProductIndex);
      _listProduitProjet.insert(_editProductIndex, _produitWithModule);
    } else {
      _listProduitProjet.add(_produitWithModule);
    }
    notifyListeners();
  }

  void initProjetWithAllInfos() {
    projetWithAllInfos = ProjetWithAllInfos(_projet, _listProduitProjet);
    notifyListeners();
  }

  List<ProduitWithModule> get listProduitProjet => _listProduitProjet;

  ClientData get client => _client;

  //TODO
  void setFinitions(String choice) {}

  ModuleData get moduleChoice => _moduleChoice;

  set moduleChoice(ModuleData module) {
    _moduleChoice = module;
    notifyListeners();
  }

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

  String get dateNow => _dateNow;

  set description(String desc) {
    _projetDesc = desc;
    notifyListeners();
  }

  String get description => _projetDesc;

  set projetNom(String nom) {
    _projetNom = nom;
    notifyListeners();
  }

  String get projetNom => _projetNom;

  set produitNom(String nom) {
    _produitNom = nom;
    notifyListeners();
  }

  String get produitNom => _produitNom;

  set gamme(GammeData gammeChoisie) {
    _produitGamme = gammeChoisie;
    notifyListeners();
  }

  GammeData get gamme => _produitGamme;

  set modelProduit(ProduitData modeleChoisi) {
    _produitModele = modeleChoisi;
    notifyListeners();
  }

  ProduitData get modelProduit => _produitModele;

  List<ProduitModuleData> get produitModules => _listProduitModuleProjet;
}
