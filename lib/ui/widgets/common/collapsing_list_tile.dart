import 'package:flutter/material.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Widget personnalisé pour les icônes de la barre de navigation personnalisée
///     Permet d'afficher le titre de la page auquel l'icône fait référence
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
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
                  ? cTheme.Colors.selectedColor
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
                        ? cTheme.TextStyles.listTileSelectedTextStyle
                        : cTheme.TextStyles.listTileDefaultTextStyle,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
