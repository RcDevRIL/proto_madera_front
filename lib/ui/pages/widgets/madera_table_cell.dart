import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class MaderaTableCell extends StatefulWidget {
  final String textCell;
  final double height, width, cellFontSize;
  final Color backgroundColor;

  const MaderaTableCell({
    Key key,
    @required this.textCell,
    @required this.height,
    @required this.width,
    @required this.cellFontSize,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _MaderaTableRow createState() => _MaderaTableRow();
}

class _MaderaTableRow extends State<MaderaTableCell> {
  final Logger log = Logger();
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
    log.d(widget.textCell);
    return Container(
      height: widget.height,
      width: widget.width,
      color: widget.backgroundColor,
      padding: EdgeInsets.only(
        top: 35,
      ),
      child: Text(
        widget.textCell,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: widget.cellFontSize),
      ),
    );
  }
}
