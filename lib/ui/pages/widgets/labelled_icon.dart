import 'package:flutter/material.dart';

///
/// Widget personnalisé pour un icône suivi d'un texte
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class LabelledIcon extends StatelessWidget {
  final Icon icon;
  final Text text;
  final MainAxisSize mASize;

  const LabelledIcon(
      {Key key, this.mASize, @required this.icon, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: mASize != null ? mASize : MainAxisSize.min,
      children: <Widget>[
        icon,
        text,
      ],
    );
  }
}
