import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart' show AuthenticationPage;

///
/// Widget personnalisé pour une barre de progression linéaire
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
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
          Provider.of<MaderaNav>(context)
              .redirectToPage(context, AuthenticationPage());
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
    TODO propager l'info de l'erreur pour quon tente la synchro à un autre moment.
    */
    try {
      Provider.of<ProviderSynchro>(context)
          .utilisateurDao
          .getUser()
          .then((lastUserData) {
        try {
          lastUserData.token != null
              ? Provider.of<ProviderSynchro>(context).synchroReferentiel().then(
                  (b) => b
                      ? Provider.of<ProviderSynchro>(context)
                          .setRefsLastSyncDate(DateTime.now().toString())
                      : null)
              : log.e('Aucun token trouvé...');
        } catch (e) {
          log.e('lastUserData error:\n$e');
        }
      });
    } catch (e) {
      log.e('getUser error:\n$e');
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
        value: progressAnimation.value,
      ),
    );
  }
}
