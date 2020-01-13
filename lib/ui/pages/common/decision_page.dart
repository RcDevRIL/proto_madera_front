import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderSize, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AuthenticationPage, HomePage;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show FailureIcon, PendingAction, SuccessIcon;

///
/// Page used to redirect user on login/logout events
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class DecisionPage extends StatefulWidget {
  static const routeName = '/redirect';
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  final log = Logger();
  bool showIt;
  bool hasToken = false;
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
    List<String> args = ModalRoute.of(context).settings.arguments;
    showIt = args[0].contains('true');
    bool logout;
    args.length == 2 ? logout = true : logout = false;
    var providerNav = Provider.of<MaderaNav>(context);
    return FutureBuilder<bool>(
      future: this._redirectUser(context),
      builder: (context, s) {
        switch (s.connectionState) {
          case ConnectionState.waiting:
            return showIt ? PendingAction() : Container();
            break;
          case ConnectionState.none:
            return showIt ? FailureIcon() : Container();
            break;
          default:
            {
              if (s.hasError || !s.hasData) {
                if (providerNav.pageIndex !=
                    -1) //ces conditions permettent d'éviter de voir les pages "sauter" lorsqu'on fait une décision
                  showIt
                      ? SchedulerBinding.instance.addPostFrameCallback((_) =>
                          providerNav.redirectToPage(
                              context, AuthenticationPage(), null))
                      : providerNav.redirectToPage(
                          context, AuthenticationPage(), null);
                return PendingAction();
              } else if (s.hasData) {
                if (s.data == true) {
                  if (providerNav.pageIndex != 0) {
                    if (!logout)
                      showIt
                          ? SchedulerBinding.instance.addPostFrameCallback(
                              (_) => providerNav.redirectToPage(
                                  context, HomePage(), null))
                          : providerNav.redirectToPage(
                              context, HomePage(), null);
                    else {
                      if (providerNav.pageIndex != -1)
                        showIt
                            ? SchedulerBinding.instance.addPostFrameCallback(
                                (_) => providerNav.redirectToPage(
                                    context, AuthenticationPage(), null))
                            : providerNav.redirectToPage(
                                context, AuthenticationPage(), null);
                    }
                  }
                  return showIt ? SuccessIcon() : Container();
                } else {
                  if (providerNav.pageIndex != -1)
                    showIt
                        ? SchedulerBinding.instance.addPostFrameCallback((_) =>
                            providerNav.redirectToPage(
                                context, AuthenticationPage(), null))
                        : providerNav.redirectToPage(
                            context, AuthenticationPage(), null);
                  return showIt ? FailureIcon() : Container();
                }
              } else {
                return showIt ? PendingAction() : Container();
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
      if (null != lastUserData.token) {
        Provider.of<ProviderSize>(context).setConfigurationSize(context);
        await Provider.of<ProviderSynchro>(context).synchro();
        await Provider.of<ProviderBdd>(context).initProjetData();
        await Provider.of<ProviderBdd>(context).initData();
        hasToken = true;
        return hasToken;
      } else {
        log.e('lastUserData error (token=null?)');
        hasToken = false;
        return hasToken;
      }
    } on Exception catch (e) {
      log.e('Error on redirection: \n$e');
      hasToken = false;
      return hasToken;
    }
  }
}
