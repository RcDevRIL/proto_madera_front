import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/ui/pages/authentication_page.dart';
import 'package:proto_madera_front/ui/pages/home_page.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';

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

  @override
  String toString() {
    //overwritten for convenience
    return '"$_pageTitle", $_pageIndex';
  }

  void updateCurrent(Type page) {
    switch (page) {
      case AuthenticationPage:
        {
          _pageTitle = 'Bienvenue sur l\'application métier MADERA !';
          _pageIndex = -1;
          log.d('Updating current navigation properties:                        \n' +
              this.toString() +
              '                    '); //pleins d'espaces car pb avec le package logger
        }
        break;
      case HomePage:
        {
          _pageTitle = 'Page d\'accueil';
          _pageIndex = 0;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case Quote:
        {
          _pageTitle = "Outil de création de devis";
          _pageIndex = 1;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case QuoteOverview:
        {
          _pageTitle = "Suivi des devis enregistrés";
          _pageIndex = 2;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case NotificationPage:
        {
          _pageTitle = "Page des notification";
          _pageIndex = 3;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case SettingsPage:
        {
          _pageTitle = "Paramètres";
          _pageIndex = 4;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;

      default:
        {
          log.e("MaderaNav.updateCurrent() ERROR:                        \n\tpage.runtimeType : " +
              "$page                        \n" +
              "Navigator properties reset to default.                        ");
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
