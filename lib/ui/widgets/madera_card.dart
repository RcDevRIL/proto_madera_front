import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// A custom widget consisting of a [Card], with rounded corners.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
class MaderaCard extends StatefulWidget {
  /// Creates a card with rounded corners
  ///
  /// The [header] and [child] arguments must not be null.
  /// Additionally, [cardHeight] and [cardWidth] must have non-negative values.

  /// Represents the header of this card.
  ///
  /// Most of the time, it's a [LabelledIcon] widget, but it can be anything else.
  final Widget header;

  /// If non-null, requires this card to have exactly this height.
  final double cardHeight;

  /// If non-null, requires this card to have exactly this width.
  final double cardWidth;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  const MaderaCard({
    Key key,
    this.cardHeight,
    this.cardWidth,
    @required this.header,
    @required this.child,
  }) : super(key: key);

  @override
  _MaderaCardState createState() => _MaderaCardState();
}

class _MaderaCardState extends State<MaderaCard> {
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
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: cTheme.MaderaColors.maderaLightGreen,
          style: BorderStyle.solid,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      color: cTheme.MaderaColors.maderaCardHeader,
      elevation: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: widget.header,
          ),
          SizedBox(height: 6.0),
          Container(
            width: widget.cardWidth,
            height: widget.cardHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            child: widget.child,
          )
        ],
      ),
    );
  }
}
