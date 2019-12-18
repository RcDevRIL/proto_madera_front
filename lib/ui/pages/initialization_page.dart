import 'package:flutter/material.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_LPI.dart';

///
/// Page permettant d'initialiser l'app
///   Dans 'custom_lpi.dart' nous exécutons la synchronisation (catch erreur si token = null)
///  - TODO vérifier la connectivité internet
///  - TODO faire progresser la barre de chargement en fonction de l'avancée des deux tâches précédentes
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class InitializationPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage("assets/img/logo-madera.png"),
                ),
                MyLinearProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
