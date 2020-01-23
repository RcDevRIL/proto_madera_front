import 'package:flutter/material.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:provider/provider.dart';

///
/// Custom widget that holds a container with a linear gradient
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class GradientFrame extends StatefulWidget {
  final Widget child;

  GradientFrame({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _GradientFrameState createState() => _GradientFrameState();
}

class _GradientFrameState extends State<GradientFrame> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Provider.of<ProviderSize>(context).gradientFrameWidth,
      height: Provider.of<ProviderSize>(context).mediaHeight / 1.3,
      constraints: BoxConstraints.tightForFinite(
        // Pas sur que ce soit utile...
        width: Provider.of<ProviderSize>(context).gradientFrameWidth,
        height: Provider.of<ProviderSize>(context).mediaHeight / 1.3,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey,
              offset: Offset(10.0, 10.0),
            ),
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.grey,
              offset: Offset(0.0, 00.0),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              cTheme.MaderaColors.maderaLightGreen,
              cTheme.MaderaColors.maderaBlueGreen
            ],
            begin: Alignment(0.0, -1.0),
            end: Alignment(0.0, 0.0),
          )),
      padding: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 4.0,
      ),
      child: widget.child,
    );
  }
}
