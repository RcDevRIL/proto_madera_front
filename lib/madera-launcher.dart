import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proto_madera_front/bloc_helpers/bloc_provider.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_bloc.dart';
import 'package:proto_madera_front/ui/pages/decision_page.dart';
import 'package:proto_madera_front/ui/pages/initialization_page.dart';
import 'package:proto_madera_front/ui/pages/home-page.dart';
import 'package:proto_madera_front/theme.dart' as CustomTheme;
import 'package:proto_madera_front/ui/pages/settings-page.dart';

class MaderaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    return BlocProvider<AuthenticationBloc>(
      bloc: AuthenticationBloc(),
      child: MaterialApp(
        title: 'Madera App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Color.fromRGBO(39, 72, 0, 1.0),
            ),
            color: Color.fromRGBO(109, 243, 115, 0.33),
          ),
        ),
        routes: {
          DecisionPage.routeName: (context) => DecisionPage(),
          SettingsPage.routeName: (context) => SettingsPage(),
          HomePage.routeName: (context) => HomePage(),
        },
        home: InitializationPage(),
      ),
    );
  }
}
