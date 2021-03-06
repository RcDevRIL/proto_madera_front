import 'package:flutter/material.dart';

/// A customizable cell to display content
///
/// This widget represents a cell in a data table. It can store text informations.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class MaderaTableCell extends StatefulWidget {
  /// Creates a widget describing a table cell.
  ///
  /// The [cellFontSize], [height], [textCell] and [width] arguments must not be null.
  /// Additionally, it is possible to define a [backgroundColor].

  /// The text to display in this cell.
  final String textCell;

  /// The height, width of the cell. And the font size of a cell.
  final double height, width, cellFontSize;

  /// The background color used for this cell.
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
      height: widget.height,
      width: widget.width,
      color: widget.backgroundColor,
      padding: EdgeInsets.only(
        top: widget.height / 2.2,
      ),
      child: Text(
        widget.textCell,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: widget.cellFontSize),
      ),
    );
  }
}
