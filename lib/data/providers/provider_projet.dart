import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/models/quote_creation_model.dart';
import 'package:proto_madera_front/data/models/quote_model.dart';

///
/// Provider permettant de gérer l'état du formulaire de création de devis
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ProviderProjet with ChangeNotifier {
  QuoteCreationModel _quoteCreationValues;
  QuoteModel _quoteValues;
  bool saved = true;
  // List<String> _addModuleValues;
  // List<String> _finitionsValues;
  final Logger log = Logger();
  final String _now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .toString()
          .substring(0, 10);
  void initAndHold() {
    if (saved)
      init();
    else
      log.e('Can' 't init a new project, save first');
  }

  void validate() {
    //TODO save en bdd?, a faire coté ui je pense pour pouvoir utiliser provider.of(context)
    saved = true;
  }

  void init() {
    //TODO Rajouter un paramètre: le clientId, puisqu'a priori si on n'initialise le stockage du formulaire, on sait pour quel client on le fait
    var clientId = 123;
    log.i('init called');
    saved = false;
    // Initialisation des champs à null en respectant les conditions des constructeurs
    _quoteCreationValues = QuoteCreationModel(
      client: {'name': '', 'adresse': '', 'tel': '', 'mail': ''},
      dateDeCreation: _now,
      descriptionProjet: '',
      refProjet: _now +
          '_MMP$clientId', //à voir comment on construit nos ref de projet? j'ai mis yyyyMMdd_MMP123, MMP pour 'MaisonModulaireProjet', 123 pour l'ID client
    );
    _quoteValues = QuoteModel(
        gamme: 'Premium',
        nomDeProduit: null,
        listeModele: {'Modèle Premium n°1': null, 'Modèle Premium n°2': null},
        listeModule: null,
        modeleChoisi: null);
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

  set clientName(String clientName) {
    _quoteCreationValues.client
        .update('name', (old) => clientName, ifAbsent: () => clientName);
    notifyListeners();
  }

  String get clientName => _quoteCreationValues.client['name'];

  set clientAdress(String clientAdress) {
    _quoteCreationValues.client
        .update('adresse', (old) => clientAdress, ifAbsent: () => clientAdress);
    notifyListeners();
  }

  String get clientAdress => _quoteCreationValues.client['adresse'];

  set clientTel(String clientTel) {
    _quoteCreationValues.client
        .update('tel', (old) => clientTel, ifAbsent: () => clientTel);
    notifyListeners();
  }

  String get clientTel => _quoteCreationValues.client['tel'];

  set clientMail(String clientMail) {
    _quoteCreationValues.client
        .update('mail', (old) => clientMail, ifAbsent: () => clientMail);
    notifyListeners();
  }

  String get clientMail => _quoteCreationValues.client['mail'];

  String get refClient => _quoteCreationValues.client.toString();

  void setNomDeProduit(String nomDeProduit) {
    _quoteValues.nomDeProduit = nomDeProduit;
    notifyListeners();
  }

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

  String get model => _quoteValues.modeleChoisi ??= 'defaultModele';

  void addModuleToProduct(Map<String, dynamic> moduleSpec) {
    // _quoteValues.listeModule.clear();
    _quoteValues.listeModule.putIfAbsent(
        'Modèle Custom (name = ${moduleSpec['name']})',
        () =>
            moduleSpec); // Je pourrais juste mettre le nom du module, mais c'est pour nous rappelé que derriere un nom il ya des informations à stocker!
  }

  Map<String, dynamic> get productModules => _quoteValues.listeModule;

  Map<String, dynamic> get modeleList => _quoteValues.listeModele;

  void setModuleListFromModelID(int modelID) {
    //il faudra faire une requete ici
    _quoteValues.listeModule = Map<String, dynamic>();
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
          _quoteValues.listeModele = {
            'Modèle Premium 1': 11,
            'Modèle Premium 2': 12,
            'Modèle Premium 3': 13,
          };
          _quoteValues.listeModule = null;
          _quoteValues.modeleChoisi = null;
        }
        break;
      case 2:
        {
          _quoteValues.listeModele = {
            'Modèle Standard 2.1': 21,
            'Modèle Standard 2.2': 22,
            'Modèle Standard 2.3': 23,
          };
          _quoteValues.listeModule = null;
          _quoteValues.modeleChoisi = null;
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

  void logQC() {
    log.i('QuoteCreation values:\n$_quoteCreationValues');
  }

  void logQ() {
    log.i('Quote values:\n${_quoteValues.toString()}');
  }

  bool isFilled(String pageName) {
    switch (pageName) {
      case 'QuoteCreation':
        return (clientAdress.isNotEmpty &&
            clientName.isNotEmpty &&
            clientTel.isNotEmpty &&
            clientMail.isNotEmpty &&
            description.isNotEmpty);
        break;
      case 'Quote':
        return (productModules != null);
        break;
      default:
        return false;
        break;
    }
  }
}
