import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

/// A custom widget representing a button.
///
/// A [MaderaButton] is based on a [RaisedButton] widget.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class MaderaButton extends StatelessWidget {
  /// Creates a custom [RaisedButton].
  ///
  /// The [child] argument must not be null.
  /// If the [onPressed] callback is null, then the button will be disabled by default.

  /// The callback that is called when the button is pressed.
  final Function onPressed;

  /// The button's label.
  ///
  /// Often a [Text] widget.
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
