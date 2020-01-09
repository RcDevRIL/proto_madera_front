import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Custom widget representing a button that closes the application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class ExitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => SystemChannels.platform.invokeMethod(
          'SystemNavigator.pop'), //Ajouter un dialog :) Dialog()      showDialog()
      tooltip: 'Fermer l\'application',
      icon: ImageIcon(
        AssetImage('assets/img/icons/off.png'),
        semanticLabel: 'Shut down app',
        size: 32.0, //bizarrement n'est pas affecté par defaultIconTheme???
      ),
    );
  }
}
