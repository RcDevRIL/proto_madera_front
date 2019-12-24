import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Custom widget pour une RadioListTile
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class MaderaRadioListTile extends StatefulWidget {
  final double width;
  final EdgeInsetsGeometry margin;
  final List<Widget> child;

  //DateFormat('yyyy-MM-dd').format(DateTime.now()) // Va être généré automatiquement à l'avenir
  const MaderaRadioListTile({
    Key key,
    this.width,
    this.margin,
    @required this.child,
  }) : super(key: key);

  @override
  _MaderaRadioListTileState createState() => _MaderaRadioListTileState();
}

class _MaderaRadioListTileState extends State<MaderaRadioListTile> {
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
      width: widget.width,
      margin: widget.margin,
      decoration: BoxDecoration(
          border: Border.all(color: cTheme.Colors.boxBorder, width: 2.0),
          borderRadius: BorderRadius.circular(20.0),
          color: cTheme.Colors.white),
      child: Column(
        children: widget.child,
      ),
    );
  }
}
