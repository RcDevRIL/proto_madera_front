import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

///
/// Provider permettant de gérer l'état du formulaire de création de devis
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class ProviderProjet with ChangeNotifier {
  List<String> quoteCreationValues;
  List quoteValues;
  List<String> addModuleValues;
  List<String> finitionValues;
  final Logger log = Logger();

  void init() {
    quoteCreationValues = List<String>(4);
    quoteValues = [
      '',
      '',
      <String>[],
    ];
    addModuleValues = List<String>(4);
  }

  void flush() {
    init();
  }

  void setGamme(String nomGamme) {
    quoteValues[0] = nomGamme;
  }

  String get gamme => quoteValues[0];

  void setModule(String nomModele) {
    quoteValues[1] = nomModele;
  }

  String get module => quoteValues[1];

  void addComponentToModule(List<String> moduleSpec) {
    List<String> moduleList = quoteValues.elementAt(2);
    quoteValues.removeLast();
    moduleList.add(moduleSpec
        .toString()); // Je pourrais juste mettre le nom du module, mais c'est pour nous rappelé que derriere un nom il ya des informations à stocker!
    quoteValues.add(moduleList);
  }

  List<String> get moduleComponents => quoteValues.elementAt(2);

  void getComponentFromModuleId(int moduleId) {
    //il faudra faire une requete ici
    switch (moduleId) {
      case 1:
        {
          quoteValues.removeLast();
          quoteValues.add(
            [
              'Composant 1.1',
              'Composant 1.2',
              'Composant 1.3',
            ],
          );
        }
        break;
      case 2:
        {
          quoteValues.removeLast();
          quoteValues.add(
            [
              'Composant 2.1',
              'Composant 2.2',
              'Composant 2.3',
            ],
          );
        }
        break;
      default:
        {
          log.e('Wrong moduleID: $moduleId');
        }
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
