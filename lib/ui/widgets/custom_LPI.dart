import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart' show DecisionPage;
import 'package:proto_madera_front/theme.dart' as cTheme;

/// Custom widget representing a linear progressbar incidator
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class MyLinearProgressIndicator extends StatefulWidget {
  final Color backgroundColor;

  MyLinearProgressIndicator({
    this.backgroundColor = Colors.white,
    Key key,
  }) : super(key: key);

  @override
  _MyLinearProgressIndicatorState createState() =>
      _MyLinearProgressIndicatorState(backgroundColor);
}

class _MyLinearProgressIndicatorState extends State<MyLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController progressController;
  Animation<double> progressAnimation;
  final Color backgroundColor;

  _MyLinearProgressIndicatorState(this.backgroundColor);

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    progressAnimation = Tween(begin: 0.0, end: 1.0).animate(progressController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Provider.of<MaderaNav>(context)
              .redirectToPage(context, DecisionPage(), ["false"]);
        }
        if (status == AnimationStatus.dismissed) {
          progressController.forward();
        }
      })
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    progressController.forward();
  }

  @override
  void didUpdateWidget(Widget oldW) {
    super.didUpdateWidget(oldW);
  }

  @override
  void dispose() {
    progressController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(cTheme.MaderaColors
            .maderaGreen), //permet d'override la propriété accentColor utilisée auparavant
        value: progressAnimation.value,
      ),
    );
  }
}
