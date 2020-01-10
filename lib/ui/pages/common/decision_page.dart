import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AuthenticationPage, HomePage;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show FailureIcon, PendingAction, SuccessIcon;

class DecisionPage extends StatefulWidget {
  static const routeName = '/redirect';
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  bool hasToken;
  var redirectTo;
  final log = Logger();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _redirectUser(context),
      builder: (context, s) {
        if (s.hasError) {
          return FailureIcon();
        } else if (s.hasData) {
          return SuccessIcon();
        } else {
          return PendingAction();
        }
      },
    );
  }

  Future<bool> _redirectUser(BuildContext context) async {
    try {
      UtilisateurData lastUserData = await Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getLastUser();
      try {
        if (lastUserData.token != null) {
          await Provider.of<ProviderSynchro>(context).synchro();
          redirectTo = HomePage();
          hasToken = true;
        } else {
          log.e('Aucun token trouvé...');
          redirectTo = AuthenticationPage();
          hasToken = false;
        }
      } catch (e) {
        hasToken = false;
        redirectTo = AuthenticationPage();
        log.e('lastUserData error (token=null?):\n$e');
      }
    } catch (e) {
      hasToken = false;
      redirectTo = AuthenticationPage();
      log.e('getUser error (db=null?):\n$e');
    }
    Provider.of<MaderaNav>(context).redirectToPage(context, redirectTo, null);
    return hasToken;
  }
}
