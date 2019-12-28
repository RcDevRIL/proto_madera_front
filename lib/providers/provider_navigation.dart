import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:provider/provider.dart';

///
/// Provider permettant de gérer l'état de la navigation
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class MaderaNav with ChangeNotifier {
  var _pageTitle;
  var _pageIndex;

  final log = Logger();

  int get pageIndex => _pageIndex ??= -1;

  String get pageTitle => _pageTitle ??= 'default';

  @override
  String toString() {
    //overwritten for convenience
    return '"$_pageTitle", $_pageIndex';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCurrent(Type page) {
    /**
     * Index pages :
     * -1 : AuthenticationPage
     * 0 : HomePage
     * 1 : QuoteCreation
     * 2 : QuoteOverview
     * 3 : NotificationPage
     * 4 : SettingsPage
     * 1 : Quote
     * 1 : AddModule
     */
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
      case QuoteCreation:
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
          _pageTitle = "Page des notifications";
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
      case AddModule:
        {
          _pageTitle = "Outil de création de devis";
          _pageIndex = 1;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case Finishings:
        {
          _pageTitle = "Outil de création de devis";
          _pageIndex = 1;
          log.d(
              'Updating current navigation properties:                        \n' +
                  this.toString() +
                  '                    ');
        }
        break;
      case ProductList:
        {
          _pageTitle = "Outil de création de devis";
          _pageIndex = 1;
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

  void redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      Navigator.of(context).pushReplacement(newRoute);
      var maderaNav = Provider.of<MaderaNav>(context);
      maderaNav.updateCurrent(page.runtimeType);
    });
  }
}
