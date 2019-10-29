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
    //il faudrait s'inspirer de home-page.dart pour faire en sorte d'avoir un feedback
    // lorsqu'on clique sur le bouton de déconnexion
    // à faire sur tout les pages donc je pense
    // puisque ce sera accessible dans le menu de navigation qu'on peut ouvrir de n'importe ou
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppBarMadera(), //visiblement on ne peut pas le mettre dans le champ appBar du Scaffold.. alors voila !!
          SizedBox(
            height: 250.0,
          ),
          Center(
            child: Stack(
              children: <Widget>[
                Text("PAGE DES PARAMETRES"),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
