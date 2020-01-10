import 'package:flutter/material.dart';

class FailureIcon extends StatelessWidget {
  const FailureIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: Center(
            child: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 50.0,
        )));
  }
}
