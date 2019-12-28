import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// A custom Box for dropdown lists inputs.
///
/// [MaderaRoundedBox] consists of a [Container] with a custom [background] color,
/// rounded corners from a [BorderRadius] and a custom [Border].
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class MaderaRoundedBox extends StatefulWidget {
  final double boxWidth;
  final double boxHeight;
  final Widget child;
  final EdgeInsetsGeometry edgeInsetsPadding;
  final EdgeInsetsGeometry edgeInsetsMargin;
  final Color color;

  MaderaRoundedBox({
    Key key,
    this.boxWidth,
    @required this.boxHeight,
    @required this.edgeInsetsPadding,
    this.edgeInsetsMargin,
    this.color,
    @required this.child,
  }) : super(key: key);

  @override
  MaderaRoundedBoxState createState() => MaderaRoundedBoxState();
}

class MaderaRoundedBoxState extends State<MaderaRoundedBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.boxWidth != null ? widget.boxWidth : null,
      height: widget.boxHeight,
      padding: widget.edgeInsetsPadding,
      margin: widget.edgeInsetsMargin != null
          ? widget.edgeInsetsMargin
          : EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: cTheme.Colors.boxBorder, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: widget.color != null ? widget.color : cTheme.Colors.white),
      child: widget.child,
    );
  }
}
