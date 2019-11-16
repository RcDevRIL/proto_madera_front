import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as CustomTheme;

class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    return MaterialApp(
      title: 'Madera App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: CustomTheme.Colors.iconsMainColor,
          ),
          color: CustomTheme.Colors.appBarMainColor,
        ),
      ),
      routes: {
        InitializationPage.routeName: (context) => InitializationPage(),
        DecisionPage.routeName: (context) => DecisionPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
        HomePage.routeName: (context) => HomePage(),
      },
      home: InitializationPage(),
    );
  }
}
