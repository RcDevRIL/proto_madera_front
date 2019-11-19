import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/authentication_page.dart';

class MyLinearProgressIndicator extends StatefulWidget {
  final Color backgroundColor;

  MyLinearProgressIndicator({this.backgroundColor, Key key}) : super(key: key);

  @override
  _MyLinearProgressIndicatorState createState() =>
      _MyLinearProgressIndicatorState(backgroundColor);
}

class _MyLinearProgressIndicatorState extends State<MyLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController progressController;
  Animation<double> progressAnimation;
  final Color backgroundColor;
  final log = Logger();

  _MyLinearProgressIndicatorState(this.backgroundColor);

  @override
  void initState() {
    super.initState();
    progressController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    progressAnimation = Tween(begin: 0.0, end: 1.0).animate(progressController)
      ..addStatusListener((status) {
        log.d('$status');
        if (status == AnimationStatus.completed) {
          _redirectToPage(context, AuthenticationPage());
        } else if (status == AnimationStatus.dismissed) {
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
  void dispose() {
    progressController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        backgroundColor: backgroundColor,
        value: progressAnimation.value,
      ),
    );
  }

  // à la base j'essayais de mettre cette méthode dans la class MaderaNav, mais ça faisait des bugs.
  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      Navigator.of(context).pushReplacement(newRoute);
      var maderaNav = Provider.of<MaderaNav>(context);
      maderaNav.updateCurrent(page.runtimeType);
    });
  }
}
