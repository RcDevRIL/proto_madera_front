import 'package:flutter/material.dart';

class SuccessIcon extends StatelessWidget {
  const SuccessIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: Center(
            child: Icon(
          Icons.check_circle,
          color: Colors.cyan,
          size: 50.0,
        )));
  }
}
