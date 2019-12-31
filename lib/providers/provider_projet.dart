import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/providers/models/quote_creation_model.dart';
import 'package:proto_madera_front/providers/models/quote_model.dart';

///
/// Provider permettant de gérer l'état du formulaire de création de devis
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class ProviderProjet with ChangeNotifier {
  QuoteCreationModel _quoteCreationValues;
  QuoteModel _quoteValues;
  Map<String, dynamic> _modeleList;
  // List<String> _addModuleValues;
  // List<String> _finitionsValues;
  final Logger log = Logger();

  void init() {
    // Initialisation des champs dans le format voulu
    _quoteCreationValues = QuoteCreationModel(
      client: {'clientId': 123},
      dateDeCreation: DateTime.now(),
      descriptionProjet: 'Initialisation',
      refProjet: 'REF',
    );
    _quoteValues = QuoteModel(
        gamme: 'premium', // ben oui de base c premium, raboule les thunes!!
        nomDeProduit: 'Produit de pigeon bien cher',
        listeModule: {'Module n°1': 1},
        modeleChoisi: 'Modèle de maison de pigeon "premium"');
    _modeleList = _quoteValues.listeModule;
    /* 
    addModuleValues = [
      '',
      '',
      '',
      '',
    ]; */
  }

  @override
  void dispose() {
    super.dispose();
  }

  void flush() {
    //TODO Enregistrer la configuration actuelle du devis en BDD
    init();
  }

  set dateCreation(String newDate) {
    _quoteCreationValues.dateDeCreation = DateTime.parse(newDate);
    notifyListeners();
  }

  String get dateCreation => _quoteCreationValues.dateDeCreation.toString();

  set idProjet(String idProjet) {
    _quoteCreationValues.refProjet = idProjet;
    notifyListeners();
  }

  String get idProjet => _quoteCreationValues.refProjet;

  void setDescription(String desc) {
    _quoteCreationValues.descriptionProjet = desc;
    notifyListeners();
  }

  String get description => _quoteCreationValues.descriptionProjet;

  void setRefClient(String refClient) {
    _quoteCreationValues.client = {"refClient:": refClient};
    notifyListeners();
  }

  String get refClient => _quoteCreationValues.client.toString();

  void setGamme(String nomGamme) {
    _quoteValues.gamme = nomGamme;
    notifyListeners();
  }

  String get gamme => _quoteValues.gamme;

  void setModel(String nomModel) {
    _quoteValues.modeleChoisi = nomModel;
    notifyListeners();
  }

  String get model => _quoteValues.modeleChoisi ??= '';

  void addModuleToProduct(Map<String, dynamic> moduleSpec) {
    _quoteValues.listeModule.clear();
    _quoteValues.listeModule.addAll(
        moduleSpec); // Je pourrais juste mettre le nom du module, mais c'est pour nous rappelé que derriere un nom il ya des informations à stocker!
  }

  Map<String, dynamic> get productModules => _quoteValues.listeModule;

  Map<String, dynamic> get modeleList => _modeleList;

  void setModuleListFromModelID(int modelID) {
    //il faudra faire une requete ici
    switch (modelID) {
      case 1:
        {
          _quoteValues.listeModule.clear();
          _quoteValues.listeModule.addAll(
            {
              'Module 1.1': 1.1,
              'Module 1.2': 1.2,
              'Module 1.3': 1.3,
            },
          );
        }
        break;
      case 2:
        {
          _quoteValues.listeModule.clear();
          _quoteValues.listeModule.addAll(
            {
              'Module 2.1': 2.1,
              'Module 2.2': 2.2,
              'Module 2.3': 2.3,
            },
          );
        }
        break;
      default:
        {
          log.e('Wrong modelID: $modelID');
        }
        break;
    }
    notifyListeners();
  }

  void setModeleListFromGammeID(int gammeID) {
    //il faudra faire une requete ici
    switch (gammeID) {
      case 1:
        {
          _quoteValues.listeModele
              .clear(); //clear de la liste des modules lorsqu'on change de gamme
          _quoteValues.listeModele.addAll(
            [
              'Modele1',
              'Modele2',
              'Modele3',
            ],
          );
        }
        break;
      case 2:
        {
          _quoteValues.listeModele
              .clear(); //clear de la liste des modules lorsqu'on change de gamme
          _quoteValues.listeModele.addAll(
            [
              'Modeleea ze.2',
              'Modeleez a2.2',
              'Modeleezae3.2',
            ],
          );
        }
        break;
      default:
        {
          log.e('Wrong gammeID: $gammeID');
        }
        break;
    }
    notifyListeners();
  }

  void saveQC(String dateCreationProjet, String idProjet, String refClient,
      String descriptionProjet) {
    log.i('QuoteCreation values:\n${_quoteCreationValues.toString()}');
    _quoteCreationValues = QuoteCreationModel(
      dateDeCreation: DateTime.parse(dateCreationProjet),
      refProjet: idProjet,
      client: {"refClient": refClient},
      descriptionProjet: descriptionProjet,
    );
    log.i('Updated QuoteCreation values:\n${_quoteCreationValues.toString()}');
  }

  void saveQ(String dropdownGammeValue, String dropdownModeleValue,
      Map<String, dynamic> componentsList) {
    log.i('QuoteCreation values:\n${_quoteValues.toString()}');
    _quoteValues = QuoteModel(
      gamme: dropdownGammeValue,
      modeleChoisi: dropdownModeleValue,
      nomDeProduit: "Produit n°1 sauvegardé",
      listeModule: componentsList,
    );
    log.i('Updated QuoteCreation values:\n${_quoteValues.toString()}');
  }
}
