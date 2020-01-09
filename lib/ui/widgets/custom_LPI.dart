import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AuthenticationPage, HomePage;
import 'package:proto_madera_front/theme.dart' as cTheme;

/// Custom widget representing a linear progressbar incidator
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
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
  bool hasToken = false;
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
          hasToken
              ? Provider.of<MaderaNav>(context)
                  .redirectToPage(context, HomePage(), null)
              : Provider.of<MaderaNav>(context)
                  .redirectToPage(context, AuthenticationPage(), null);
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
    /* Utilisation de didUpdateWidget pour faire la synchro au moment du progrès de la barre chargement 
    Si le dernier utilisateur enregistré n'a pas de token, on ne fait pas la synchro et on log une erreur.
    */
    try {
      Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getUser()
          .then((lastUserData) {
        try {
          if (lastUserData.token != null) {
            Provider.of<ProviderSynchro>(context).synchro();
            hasToken = true;
          } else {
            log.e('Aucun token trouvé...');
            hasToken = false;
          }
        } catch (e) {
          hasToken = false;
          log.e('lastUserData error (token=null?):\n$e');
        }
      });
    } catch (e) {
      hasToken = false;
      log.e('getUser error (db=null?):\n$e');
    }
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
