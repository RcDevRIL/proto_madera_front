import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Premier Widget de l'application.
/// - Configuration Providers
/// - Configuration routing
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    MaderaNav maderaNav = new MaderaNav();
    ProviderBdd providerBdd = new ProviderBdd();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (c) => maderaNav,
          ),
          ChangeNotifierProvider(
            create: (c) => providerBdd,
          ),
          ChangeNotifierProxyProvider<ProviderBdd, ProviderLogin>(
            create: (context) => ProviderLogin(db: providerBdd.db),
            update: (context, bdd, login) => ProviderLogin(db: bdd.db),
          ),
          ChangeNotifierProxyProvider<ProviderBdd, ProviderSynchro>(
            create: (context) => ProviderSynchro(
              db: providerBdd.db,
              daosSynchroList: providerBdd.daosSynchroList,
            ),
            update: (context, bdd, login) => ProviderSynchro(
              db: bdd.db,
              daosSynchroList: providerBdd.daosSynchroList,
            ),
          ),
        ],
        //TODO faire la redirection si l'utilisateur est déjà conneté ? Test en envoyant le token ?
        child: MaterialApp(
          title: maderaNav.pageTitle,
          theme: ThemeData(
            primarySwatch: Colors.green,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: cTheme.Colors.iconsMainColor,
              ),
              color: cTheme.Colors.appBarMainColor,
            ),
          ),
          initialRoute: InitializationPage.routeName,
          routes: {
            InitializationPage.routeName: (context) => InitializationPage(),
            SettingsPage.routeName: (context) => SettingsPage(),
            HomePage.routeName: (context) => HomePage(),
            Quote.routeName: (context) => Quote(),
            QuoteOverview.routeName: (context) => QuoteOverview(),
            NotificationPage.routeName: (context) => NotificationPage()
          },
        ));
  }
}
