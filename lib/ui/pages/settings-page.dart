import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;

    return new Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Paramètres de l'application"),
        centerTitle: false,
      ),
      body: new Stack(
        children: <Widget>[
          Center(
            child: Text("PAGE DES PARAMETRES"),
          ),
        ],
      ),
    );
  }
}
