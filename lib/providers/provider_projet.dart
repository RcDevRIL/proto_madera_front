import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

///
/// Provider permettant de gérer l'état du formulaire de création de devis
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class ProviderProjet with ChangeNotifier {
  List<String> _quoteCreationValues;
  List _quoteValues;
  List<String> _modeleList;
  List<String> _addModuleValues;
  List<String> _finitionValues;
  final Logger log = Logger();

  void init() {
    // Initialisation des champs dans le format voulu
    _quoteCreationValues = [
      '',
      '',
      '',
      '',
    ];
    _quoteValues = [
      '',
      '',
      <String>[],
    ];
    _modeleList = [];
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

  void setDate(String dateCreationProjet) {
    _quoteCreationValues[0] = dateCreationProjet;
  }

  String get dateCreation => _quoteCreationValues[0];

  void setIdProjet(String idProjet) {
    _quoteCreationValues[1] = idProjet;
  }

  String get idProjet => _quoteCreationValues[1];

  void setDescription(String desc) {
    _quoteCreationValues[3] = desc;
  }

  String get description => _quoteCreationValues[3];

  void setRefClient(String refClient) {
    _quoteCreationValues[2] = refClient;
  }

  String get refClient => _quoteCreationValues[2];

  void setGamme(String nomGamme) {
    _quoteValues[0] = nomGamme;
  }

  String get gamme => _quoteValues[0];

  void setModel(String nomModel) {
    _quoteValues[1] = nomModel;
  }

  String get model => _quoteValues[1] ??= '';

  void addModuleToProduct(List<String> moduleSpec) {
    List<String> moduleList = _quoteValues.elementAt(2);
    _quoteValues.removeLast();
    moduleList.add(moduleSpec
        .toString()); // Je pourrais juste mettre le nom du module, mais c'est pour nous rappelé que derriere un nom il ya des informations à stocker!
    _quoteValues.add(moduleList);
  }

  List<String> get productModules => _quoteValues.elementAt(2);

  List<String> get modeleList => _modeleList;

  void setModuleListFromModelID(int modelID) {
    //il faudra faire une requete ici
    switch (modelID) {
      case 1:
        {
          _quoteValues.removeLast();
          _quoteValues.add(
            [
              'Module 1.1',
              'Module 1.2',
              'Module 1.3',
            ],
          );
        }
        break;
      case 2:
        {
          _quoteValues.removeLast();
          _quoteValues.add(
            [
              'Module 2.1',
              'Module 2.2',
              'Module 2.3',
            ],
          );
        }
        break;
      default:
        {
          log.e('Wrong modelID: $modelID');
        }
        break;
    }
  }

  void setModeleListFromGammeID(int gammeID) {
    //il faudra faire une requete ici
    switch (gammeID) {
      case 1:
        {
          _modeleList.clear();
          _modeleList.addAll(
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
          _modeleList.clear();
          _modeleList.addAll(
            [
              'Modeleea ze.2',
              'Modele2.2',
              'Modele3.2',
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
  }

  void saveQC(String dateCreationProjet, String idProjet, String refClient,
      String descriptionProjet) {
    log.i('QuoteCreation values:\n$_quoteCreationValues');
    _quoteCreationValues.clear(); //clean la liste
    _quoteCreationValues.addAll([
      //update la liste
      dateCreationProjet,
      idProjet,
      refClient,
      descriptionProjet,
    ]);
    log.i('Updated QuoteCreation values:\n$_quoteCreationValues');
  }

  void saveQ(String dropdownGammeValue, String dropdownModeleValue,
      List<String> componentsList) {
    log.i('QuoteCreation values:\n$_quoteValues');
    _quoteValues.clear(); //clean la liste
    _quoteValues.addAll([
      //update la liste
      dropdownGammeValue,
      dropdownModeleValue,
      componentsList,
    ]);
    log.i('Updated QuoteCreation values:\n$_quoteValues');
  }
}
