import 'package:flutter/material.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;

/// Custom widget representing the icons of our custom drawer.
///
/// It allows us to display the icons of our custom drawer,
/// as well as the title for each corresponding icon.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class CollapsingListTile extends StatefulWidget {
  /// Creates a collapsible list of tiles.
  ///
  /// The [title], [icon], and [animationController] arguments must not be null.
  /// Additionally, if the [onTap] callback is null, then the list of tile will be unclickable by default.

  /// The title to be displayed.
  final String title;

  /// The icon linked to the [title].
  final IconData icon;

  /// The animation used to display the title of the icon.
  final AnimationController animationController;

  /// When true, the icon is set to active, and changes color.
  final bool isSelected;

  /// The callback function that is called when the [InkWell] is tapped.
  final Function onTap;

  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      @required this.animationController,
      this.isSelected = false,
      this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(
            begin: cTheme.Dimens.drawerMinWitdh,
            end: cTheme.Dimens.drawerMaxWidth)
        .animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment:
              (widthAnimation.value >= cTheme.Dimens.drawerMaxWidth)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected
                  ? cTheme.MaderaColors.selectedColor
                  : Colors.white30,
              size: cTheme.Dimens.drawerIconSize,
            ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= cTheme.Dimens.drawerMaxWidth)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? cTheme.MaderaTextStyles.listTileSelectedTextStyle
                        : cTheme.MaderaTextStyles.defaultTextStyle
                            .apply(color: Colors.white70),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
