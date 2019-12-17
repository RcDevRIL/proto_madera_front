import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_madera_front/providers/provider_synchro.dart';
import 'package:proto_madera_front/providers/providers.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:provider/provider.dart';

///
/// Premier Widget de l'application.
/// - Configuration Providers
/// - Configuration routing
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    //TODO initialiser la base de données ici ?
    ProviderLogin providerLogin = ProviderLogin();
    ProviderSynchro providerSynchro = ProviderSynchro();
    MaderaNav providerNavigation = MaderaNav();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: providerLogin,
          ),
          ChangeNotifierProvider.value(
            value: providerNavigation,
          ),
          ChangeNotifierProvider.value(
            value: providerSynchro,
          ),
        ],
        //TODO faire la redirection si l'utilisateur est déjà conneté ? Test en envoyant le token ?
        child: MaterialApp(
          title: providerNavigation.pageTitle,
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
