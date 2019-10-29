import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/pages/widgets/log_out_button.dart';

class AppBarMadera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ici il va falloir utiliser un BLoC "Navigation" pour récupérer le titre de la page, il faut l'implémenter ^^
    // ça aidera également pour le menu de navigation qui doit savoir sur quel page on est
    //on aura un truc comme ça (en plus de rendre le wiget stateful)
    //NavigationBloc bloc = BlocProvider.of<NavigationBloc>(context);
    //return BlocEventStateBuilder<NavigationState>(bloc: bloc, builder: BuildContext c, Navigation State)...........
    return AppBar(
      primary: true,
      elevation: 50.0,
      backgroundColor: Color.fromRGBO(109, 243, 115, 0.33),
      iconTheme: IconThemeData(
        color: Color.fromRGBO(39, 72, 0, 1.0),
      ),
      // leading: Container(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "HOME PAGE",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromRGBO(39, 72, 0, 1.0),
            ),
          ),
          Image(
            image: AssetImage("assets/img/logo-madera.png"),
          ),
        ],
      ),
      centerTitle: true,
      actions: <Widget>[
        LogOutButton(), //à terme il doit être dans le Drawer (ou menu de navigation)
      ],
    );
  }
  // AppBarMadera({Key key, Widget title})
  // // C'est ici que je galère, j'arrive pas à dire qu'il peut contenir d'autres Widgets,
  // // mais que le premier sera tjr l'icône quoi qu'il arrive
  //   : super(key: key, title: title, actions:<Widget>[
  //       new IconButton(
  //         icon: new ImageIcon(
  //           AssetImage("assets/img/logo-madera.png"),
  //           color: null,
  //         ),
  //         onPressed: null,
  //         iconSize: 150,
  //         color: null,
  //         alignment: Alignment.centerLeft,
  //       )

  //   ]);
}
