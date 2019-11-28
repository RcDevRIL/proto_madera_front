import 'package:flutter/material.dart';

class LabelledIcon extends StatelessWidget {
  final Icon icon;
  final Text text;
  final MainAxisSize mASize;

  const LabelledIcon(
      {Key key,
      @required this.mASize,
      @required this.icon,
      @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: mASize,
      children: <Widget>[
        icon,
        text,
      ],
    );
  }
}
