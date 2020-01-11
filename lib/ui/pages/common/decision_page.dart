import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AuthenticationPage, HomePage;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show FailureIcon, PendingAction, SuccessIcon;
import 'package:provider/provider.dart';

class DecisionPage extends StatefulWidget {
  static const routeName = '/redirect';
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  final log = Logger();
  Future<bool> _data;

  @override
  void didChangeDependencies() {
    //_data = _redirectUser(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: this._redirectUser(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: PendingAction(),
            );
          case ConnectionState.none:
            return Center(
              child: FailureIcon(),
            );
          default:
            return SuccessIcon();
        }
      },
    );
    /*return FutureBuilder<bool>(
      future: _data,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return PendingAction();
        if (snapshot.hasData) {
          if (snapshot.data == true)
            return SuccessIcon();
          else
            return FailureIcon();
        }
        return PendingAction();
      },
    );*/
  }

  _fetchData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  Future<bool> _redirectUser(BuildContext context) async {
    bool hasToken;
    var redirectTo;
    try {
      UtilisateurData lastUserData = await Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getLastUser();
      if (lastUserData.token != null) {
        try {
          await Provider.of<ProviderSize>(context).setConfigurationSize(context);
          await Provider.of<ProviderSynchro>(context).synchro();
          await Provider.of<ProviderBdd>(context).initProjetData();
          await Provider.of<ProviderBdd>(context).initData();
          hasToken = true;
          redirectTo = HomePage();
        } on Exception catch (e) {
          hasToken = false;
          redirectTo = AuthenticationPage();
          log.e('lastUserData error (token=null?):\n$e');
        }
      } else {
        hasToken = false;
        redirectTo = AuthenticationPage();
        log.e('lastUserData error (token=null?)');
      }
    } on Exception catch (e) {
      hasToken = false;
      redirectTo = AuthenticationPage();
      log.e('getUser error (db=null?):\n$e');
    }
    Provider.of<MaderaNav>(context).redirectToPage(context, redirectTo, null);
    return hasToken;
  }
}
