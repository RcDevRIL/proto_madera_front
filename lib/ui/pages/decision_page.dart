import 'package:flutter/material.dart';

class DecisionPage extends StatelessWidget {
  static const routeName = '/decision';
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
// TODO: Je laisse car je me dis que y aura peut etre un peu de logique en "haut" de l'application??
//       Avant ça servait à afficher la page init, login, ou home en fonction de l'état des bloc auth et appinit

/* import 'package:proto_madera_front/blocs/authentication/authentication_state.dart';
class DecisionPage extends StatefulWidget {
  static const routeName = '/decision';
  @override
  _DecisionPageState createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This page does not need to display anything since it will
    // always remain behind any active page (and thus 'hidden').
    return Container();
  }
} */
/* void _redirectToPage(BuildContext context, Widget page) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    MaterialPageRoute newRoute =
        MaterialPageRoute(builder: (BuildContext context) => page);

    Navigator.of(context)
        .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
  });
} */
