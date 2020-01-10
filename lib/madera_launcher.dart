import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_madera_front/ui/pages/common/decision_page.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Root of the application.
/// - Providers Configuration
/// - Routing Configuration
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    ProviderBdd providerBdd =
        ProviderBdd(); // Pas sur de la stabilité. Warning 'Two opened Databases' revient mnt à l'ouverture de l'app???
    //J'ai essayé d'enlever cette variable mais erreur sur les proxyProvider car j'essayais d'utiliser Provider.of(context)
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MaderaNav>(
            create: (c) => MaderaNav(),
          ),
          ChangeNotifierProvider<ProviderProjet>(
            create: (c) => ProviderProjet(),
          ),
          ChangeNotifierProvider<ProviderBdd>(
            create: (c) => providerBdd,
          ),
          ChangeNotifierProxyProvider<ProviderBdd, ProviderLogin>(
            create: (c) => ProviderLogin(db: ProviderBdd.db),
            update: (c, bdd, login) => ProviderLogin(db: ProviderBdd.db),
          ),
          ChangeNotifierProxyProvider<ProviderBdd, ProviderSynchro>(
            create: (c) => ProviderSynchro(
              db: ProviderBdd.db,
              daosSynchroList: providerBdd.daosSynchroList,
            ),
            update: (c, bdd, login) => ProviderSynchro(
              db: ProviderBdd.db,
              daosSynchroList: bdd.daosSynchroList,
            ),
          ),
        ],
        //TODO faire la redirection si l'utilisateur est déjà conneté ? Test en envoyant le token ?
        child: MaterialApp(
          title: 'Madera Constructions',
          theme: cTheme.MaderaTheme.maderaLightTheme,
          initialRoute: InitializationPage.routeName,
          routes: {
            InitializationPage.routeName: (context) => InitializationPage(),
            DecisionPage.routeName: (context) => DecisionPage(),
            SettingsPage.routeName: (context) => SettingsPage(),
            HomePage.routeName: (context) => HomePage(),
            ProductCreation.routeName: (context) => ProductCreation(),
            QuoteOverview.routeName: (context) => QuoteOverview(),
            NotificationPage.routeName: (context) => NotificationPage()
          },
        ));
  }
}
