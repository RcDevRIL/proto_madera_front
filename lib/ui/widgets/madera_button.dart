import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

///
/// Widget personnalisé pour un bouton
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
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
        textColor: Colors.white, //override theme
        elevation: 5.0,
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}
