import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/pages/user/profile_page.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaDialog, MaderaButton;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Provider to handle the navigation state of application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
class MaderaNav with ChangeNotifier {
  var _pageTitle;
  var _pageIndex;

  final log = Logger();

  int get pageIndex => _pageIndex ??= -1;

  String get pageTitle => _pageTitle ??= 'default';

  @override
  String toString() {
    //overwritten for convenience
    return '\'$_pageTitle\', $_pageIndex';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void updateCurrent(Type page) {
    /**
     * Index pages :
     * -2 : DecisionPage
     * -1 : AuthenticationPage
     *  0 : HomePage
     *  1 : QuoteCreation
     *  1 : Quote
     *  1 : AddModule
     *  2 : QuoteOverview
     *  3 : NotificationPage
     *  4 : SettingsPage
     *  5 : UserProfilePage
     */
    switch (page) {
      case DecisionPage:
        {
          _pageTitle = 'redirection page';
          _pageIndex = -2;
          // log.d('Updating current navigation properties:                        \n' +
          //     this.toString() +
          //     '                    '); //pleins d'espaces car pb avec le package logger
        }
        break;
      case AuthenticationPage:
        {
          _pageTitle = 'Bienvenue sur l\'application métier MADERA !';
          _pageIndex = -1;
          // log.d('Updating current navigation properties:                        \n' +
          //     this.toString() +
          //     '                    '); //pleins d'espaces car pb avec le package logger
        }
        break;
      case HomePage:
        {
          _pageTitle = 'Page d\'accueil';
          _pageIndex = 0;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case QuoteCreation:
        {
          _pageTitle = 'Outil de création de devis';
          _pageIndex = 1;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case QuoteOverview:
        {
          _pageTitle = 'Suivi des devis enregistrés';
          _pageIndex = 2;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case NotificationPage:
        {
          _pageTitle = 'Page des notifications';
          _pageIndex = 3;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case SettingsPage:
        {
          _pageTitle = 'Paramètres';
          _pageIndex = 4;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case ProductCreation:
        {
          _pageTitle = 'Outil de création de devis';
          _pageIndex = 1;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case AddModule:
        {
          _pageTitle = 'Outil de création de devis';
          _pageIndex = 1;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case Finishings:
        {
          _pageTitle = 'Outil de création de devis';
          _pageIndex = 1;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case ProductList:
        {
          _pageTitle = 'Outil de création de devis';
          _pageIndex = 1;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      case UserProfilePage:
        {
          _pageTitle = 'Profil';
          _pageIndex = 5;
          // log.d(
          //     'Updating current navigation properties:                        \n' +
          //         this.toString() +
          //         '                    ');
        }
        break;
      default:
        {
          log.e('MaderaNav.updateCurrent() ERROR:                        \n\tpage.runtimeType : ' +
              '$page                        \n' +
              'Navigator properties reset to default.                        ');
          _pageTitle = 'default';
          _pageIndex = -1;
        }
        break;
    }
    notifyListeners();
  }

  void redirectToPage(BuildContext context, Widget page, List<String> args) {
    if (args != null)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MaterialPageRoute newRoute = MaterialPageRoute(
            builder: (BuildContext context) => page,
            settings: RouteSettings(arguments: args));
        Navigator.of(context).pushReplacement(newRoute);
        updateCurrent(page.runtimeType);
      });
    else
      WidgetsBinding.instance.addPostFrameCallback((_) {
        MaterialPageRoute newRoute = MaterialPageRoute(
          builder: (BuildContext context) => page,
        );
        Navigator.of(context).pushReplacement(newRoute);
        updateCurrent(page.runtimeType);
      });
  }

  ///Custom alert dialog when user can't do anything but accept message.
  ///Can accept a Page to redirect on click on the 'Ok' button
  void showNothingYouCanDoPopup(BuildContext context, IconData icon,
          String title, String message, Widget thenRedirectToPage) =>
      showPopup(
        context,
        icon,
        title,
        Text(message),
        [
          MaderaButton(
            key: Key('ok-button'),
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              if (thenRedirectToPage != null)
                redirectToPage(context, thenRedirectToPage, null);
            },
          ),
        ],
      );
  void showPopup(BuildContext context, IconData icon, String title, Widget body,
      List<Widget> actions) {
    Color titleAndIconColor;
    if (icon == Icons.warning)
      titleAndIconColor = Colors.red;
    else
      titleAndIconColor = cTheme.MaderaColors.textHeaderColor;
    showDialog(
      barrierDismissible:
          false, // /!\ Rend obligatoire le clic sur un bouton qui fait Navigator.of(context).pop() /!\
      context: context,
      builder: (BuildContext context) {
        return MaderaDialog(
          titleAndIconColor: titleAndIconColor,
          title: title,
          icon: icon,
          body: body,
          actions: actions,
        );
      },
    );
  }
}
