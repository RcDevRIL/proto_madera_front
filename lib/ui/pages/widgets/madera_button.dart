import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
        color: Color.fromRGBO(139, 195, 74, 1.0),
        textColor: Colors.white,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Color.fromRGBO(117, 117, 117, 0.5),
            width: 2.0,
          ),
        ),
        onPressed: this.onPressed,
        child: this.child,
      ),
    );
  }
}
