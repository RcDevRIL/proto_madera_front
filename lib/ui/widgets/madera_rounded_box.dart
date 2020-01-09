import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// A custom Box for dropdown lists inputs.
///
/// [MaderaRoundedBox] consists of a [Container] with a custom [background] color,
/// rounded corners from a [BorderRadius] and a custom [Border].
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class MaderaRoundedBox extends StatefulWidget {
  /// Creates a box with rounded corners.
  ///
  /// The [boxHeight], [child] and [edeInsetsPadding] arguments must not be null.
  /// Additionally, the [boxWidth], [edgeInsetsPadding] and [color] can be used to better fit our expectations.

  /// If non-null, requires this rounded box to have exactly this width.
  final double boxWidth;

  /// Requires this rounded box to have exactly this height.
  final double boxHeight;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// The [child] is placed inside this padding.
  final EdgeInsetsGeometry edgeInsetsPadding;

  /// Empty space to surround the [child].
  final EdgeInsetsGeometry edgeInsetsMargin;

  /// The primary color to use for this box.
  final Color color;

  MaderaRoundedBox({
    Key key,
    this.boxWidth,
    @required this.boxHeight,
    @required this.edgeInsetsPadding,
    this.edgeInsetsMargin = const EdgeInsets.all(4),
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
      margin: widget.edgeInsetsMargin,
      decoration: BoxDecoration(
          border: Border.all(color: cTheme.MaderaColors.boxBorder, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: widget.color != null
              ? widget.color
              : Theme.of(context).backgroundColor),
      child: widget.child,
    );
  }
}
