import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class MaderaTableRow extends StatefulWidget {
  final String textRow;

  const MaderaTableRow({Key key, @required this.textRow}) : super(key: key);

  @override
  _MaderaTableRow createState() => _MaderaTableRow();
}

class _MaderaTableRow extends State<MaderaTableRow> {
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
      height: 100,
      width: 250,
      padding: EdgeInsets.only(
        top: 35,
      ),
      child: Text(
        widget.textRow,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
