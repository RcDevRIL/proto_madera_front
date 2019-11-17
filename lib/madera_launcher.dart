import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_madera_front/providers/provider-login.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';

import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as CustomTheme;
import 'package:provider/provider.dart';

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
          )
        ],
        child: MaterialApp(
          title: providerNavigation.pageTitle,
          theme: ThemeData(
            primarySwatch: Colors.green,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: CustomTheme.Colors.iconsMainColor,
              ),
              color: CustomTheme.Colors.appBarMainColor,
            ),
          ),
          initialRoute: InitializationPage.routeName,
          routes: {
            InitializationPage.routeName: (context) => InitializationPage(),
            SettingsPage.routeName: (context) => SettingsPage(),
            HomePage.routeName: (context) => HomePage(),
          },
        ));
  }
}
