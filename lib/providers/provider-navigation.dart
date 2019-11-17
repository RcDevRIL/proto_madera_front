import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/authentication_page.dart';
import 'package:proto_madera_front/ui/pages/home_page.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';

class NavigationModel {
  final String title;
  final IconData iconData;
  const NavigationModel({this.iconData, this.title});
}

const List<NavigationModel> navigationItems = [
  NavigationModel(title: "Accueil", iconData: Icons.apps),
  NavigationModel(title: "Outil Devis", iconData: Icons.assignment),
  NavigationModel(title: "Search", iconData: Icons.search),
  NavigationModel(title: "Notifications", iconData: Icons.notifications),
  NavigationModel(title: "Settings", iconData: Icons.settings),
];

class MaderaNav with ChangeNotifier {
  var _pageTitle;
  var _pageIndex;

  final log = Logger();

  int get pageIndex {
    if (_pageIndex == null) _pageIndex = -1;
    return _pageIndex;
  }

  String get pageTitle {
    if (_pageTitle == null) _pageTitle = 'default';
    return _pageTitle;
  }

  void updateCurrent(Type page) {
    switch (page) {
      case HomePage:
        {
          _pageTitle = 'Page d\'accueil';
          _pageIndex = 0;
          log.d(
              'Updating current navigation properties:\n"$_pageTitle", $_pageIndex                    '); //pleins d'espaces car pb avec le package logger
        }
        break;
      case AuthenticationPage:
        {
          _pageTitle = "Bienvenue sur l'application métier MADERA !";
          _pageIndex = -1;
          log.d(
              'Updating current navigation properties:\n"$_pageTitle", $_pageIndex                    ');
        }
        break;
      case SettingsPage:
        {
          _pageTitle = "Paramètres";
          _pageIndex = 4;
          log.d(
              'Updating current navigation properties:\n"$_pageTitle", $_pageIndex                    ');
        }
        break;

      default:
        {
          log.d("default");
          _pageTitle = "default";
          _pageIndex = -1;
        }
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
