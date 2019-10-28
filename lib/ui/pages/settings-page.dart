import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/pages/widgets/appbar_madera.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBarMadera(
          title: Text("Paramètres de l'application"),
        ),
        body: Stack(
          children: <Widget>[
            Center(
              child: Text("PAGE DES PARAMETRES"),
            ),
          ],
        ),
      )
    );
  }
}
