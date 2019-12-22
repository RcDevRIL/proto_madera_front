import 'package:flutter/cupertino.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class MaderaTableColumn extends StatefulWidget {
  final String textHeader;

  const MaderaTableColumn({Key key, @required this.textHeader})
      : super(key: key);
  @override
  _MaderaTableColumn createState() => _MaderaTableColumn();
}

class _MaderaTableColumn extends State<MaderaTableColumn> {
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
      padding: EdgeInsets.only(top: 35),
      color: cTheme.Colors.appBarMainColor,
      child: Text(
        widget.textHeader,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
