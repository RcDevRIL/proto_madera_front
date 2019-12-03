import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Widget personnalisé pour un bouton qui ferme l'application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return /* Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child:  */
        IconButton(
      onPressed: () => SystemChannels.platform.invokeMethod(
          'SystemNavigator.pop'), //Ajouter un dialog :) Dialog()      showDialog()
      tooltip: "Fermer l'application",
      icon: ImageIcon(
        AssetImage("assets/img/icons/off.png"),
        color: cTheme.Colors.appBarTitle,
      ),
      color: cTheme.Colors.appBarTitle,
      iconSize: 32.0,
    );
    // );
  }
}
