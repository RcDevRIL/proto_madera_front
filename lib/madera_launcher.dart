import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    ProviderLogin providerLogin = ProviderLogin();
    MaderaNav providerNavigation = MaderaNav();
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: providerLogin,
          ),
          ChangeNotifierProvider.value(
            value: providerNavigation,
          ),
        ],
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
