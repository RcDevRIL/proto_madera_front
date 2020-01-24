import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show ExitButton;
import 'package:proto_madera_front/ui/pages/pages.dart' show HomePage;

/// Custom widget representing a customized [AppBar]
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class AppBarMadera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
      ),
      child: Consumer<MaderaNav>(
        builder: (context, mN, child) => AppBar(
          primary: true,
          automaticallyImplyLeading: false,
          leading: mN.pageIndex == -1 ? ExitButton() : null,
          title: Text(
            mN.pageTitle,
          ),
          centerTitle: false,
          actions: <Widget>[
            mN.pageIndex !=
                    -1 // si page login ou bug, on ne veux pas de bouton qui redirige à l'accueil
                ? FlatButton(
                    padding: EdgeInsets.all(0.0), //override theme
                    shape: Border.all(style: BorderStyle.none), //override theme
                    onPressed: () =>
                        mN.redirectToPage(context, HomePage(), null),
                    child: Image(
                      image: AssetImage('assets/img/logo-madera.png'),
                    ),
                  )
                : Image(
                    image: AssetImage('assets/img/logo-madera.png'),
                  ),
          ],
        ),
      ),
    );
  }
}
