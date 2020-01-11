import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderSize, ProviderSynchro;
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
  final log = Logger();

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderSize>(context).setConfigurationSize(context);
    return FutureBuilder(
      future: _redirectUser(context),
      builder: (context, s) {
        if (s.hasError) {
          Provider.of<MaderaNav>(context)
              .redirectToPage(context, AuthenticationPage(), null);
          return FailureIcon();
        } else if (s.hasData) {
          if (s.data == true) {
            Provider.of<MaderaNav>(context)
                .redirectToPage(context, HomePage(), null);
            return SuccessIcon();
          } else {
            Provider.of<MaderaNav>(context)
                .redirectToPage(context, AuthenticationPage(), null);
            return FailureIcon();
          }
        } else {
          Provider.of<MaderaNav>(context)
              .redirectToPage(context, AuthenticationPage(), null);
          return PendingAction();
        }
      },
    );
  }

  Future<bool> _redirectUser(BuildContext context) async {
    bool hasToken;
    try {
      UtilisateurData lastUserData = await Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getLastUser();
      try {
        if (lastUserData.token != null) {
          await Provider.of<ProviderSynchro>(context).synchro();
          await Provider.of<ProviderBdd>(context).initProjetData();
          Provider.of<ProviderBdd>(context).initData();
          hasToken = true;
        } else {
          log.e('Aucun token trouvé...');
          hasToken = false;
        }
      } catch (e) {
        hasToken = false;
        log.e('lastUserData error (token=null?):\n$e');
      }
    } catch (e) {
      hasToken = false;
      log.e('getUser error (db=null?):\n$e');
    }
    return hasToken;
  }
}
