import 'package:flutter/material.dart';

/// A customized Widget representing an icon next to a text.
///
/// A [LabelledIcon] holds an [Icon], and a [Text] next to it.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class LabelledIcon extends StatelessWidget {
  /// Create a labelled icon.
  ///
  /// The [icon] and [text] arguments must not be null.
  /// Additionally, [mASize] must be of type [MainAxisSize].

  /// The icon to be displayed in this labelled icon.
  final Icon icon;

  /// The text to be displayed in this labelled icon.
  final Text text;

  /// The main axis size for this widget.
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
        SizedBox(
          width: 5.0,
        ),
        text,
      ],
    );
  }
}
