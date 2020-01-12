import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerNav = Provider.of<MaderaNav>(context);
    return FutureBuilder<bool>(
      future: this._redirectUser(context),
      builder: (context, s) {
        switch (s.connectionState) {
          case ConnectionState.waiting:
            return PendingAction();
            break;
          case ConnectionState.none:
            return FailureIcon();
            break;
          default:
            {
              if (s.hasError) {
                //de ce que j'ai testé j'ai plutot l'impression que le future est en erreur après le redirectToPage
                // et c'est ce cas qui fait apparaitre le looking up deactivated widget. Si je mettais un PostFrame callback, ça plante, sans ça ne plante pas de mon coté
                SchedulerBinding.instance.addPostFrameCallback((_) =>
                    providerNav.redirectToPage(
                        context, AuthenticationPage(), null));
                return FailureIcon();
              } else if (s.hasData) {
                if (s.data == true) {
                  SchedulerBinding.instance.addPostFrameCallback((_) =>
                      providerNav.redirectToPage(context, HomePage(), null));
                  return SuccessIcon();
                } else {
                  SchedulerBinding.instance.addPostFrameCallback((_) =>
                      providerNav.redirectToPage(
                          context, AuthenticationPage(), null));
                  return FailureIcon();
                }
              } else {
                return PendingAction();
              }
            }
        }
      },
    );
  }

  Future<bool> _redirectUser(BuildContext context) async {
    try {
      UtilisateurData lastUserData = await Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getLastUser();
      if (lastUserData.token != null) {
        try {
          Provider.of<ProviderSize>(context).setConfigurationSize(context);
          await Provider.of<ProviderSynchro>(context).synchro();
          await Provider.of<ProviderBdd>(context).initProjetData();
          await Provider.of<ProviderBdd>(context).initData();
          return true;
        } on Exception catch (e) {
          log.e('lastUserData error (token=null?):\n$e');
          return false;
        }
      } else {
        log.e('lastUserData error (token=null?)');
        return false;
      }
    } on Exception catch (e) {
      log.e('getUser error (db=null?):\n$e');
      return false;
    }
  }
}
