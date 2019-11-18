import 'package:flutter/material.dart';

class LabelledIcon extends StatelessWidget {
  final Icon icon;
  final Text text;

  const LabelledIcon({Key key, this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        text,
      ],
    );
  }
}
