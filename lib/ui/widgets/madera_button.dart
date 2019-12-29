import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Widget personnalisé pour un bouton
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class MaderaButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Logger log = Logger();

  MaderaButton({
    Key key,
    @required this.onPressed,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: cTheme.MaderaColors.maderaGreen,
        textColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: cTheme.MaderaColors.maderaButtonBorder,
            width: 2.0,
          ),
        ),
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}
