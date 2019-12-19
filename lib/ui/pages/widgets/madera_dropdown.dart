import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// A custom Box for dropdown lists inputs.
///
/// [MaderaDropDown] consists of a [Container] with a custom [background] color,
/// rounded corners from a [BorderRadius] and a custom [Border].
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class MaderaDropDown extends StatefulWidget {
  final double boxWidth;
  final double boxHeight;
  final Widget child;

  const MaderaDropDown({
    Key key,
    this.boxWidth,
    this.boxHeight,
    @required this.child,
  }) : super(key: key);

  @override
  MaderaDropDownState createState() => MaderaDropDownState();
}

class MaderaDropDownState extends State<MaderaDropDown> {
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
      width: widget.boxWidth,
      height: widget.boxHeight,
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
          border: Border.all(color: cTheme.Colors.boxBorder, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: cTheme.Colors.white),
      child: widget.child,
    );
  }
}
