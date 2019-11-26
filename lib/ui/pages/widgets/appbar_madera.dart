import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/widgets/exit_button.dart';
import 'package:proto_madera_front/ui/pages/home_page.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class AppBarMadera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          /* BoxConstraints(
        maxHeight: MediaQuery.of(context).devicePixelRatio * 28,
        minHeight: MediaQuery.of(context).devicePixelRatio * 28,
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ), */
          BoxConstraints.tightFor(
        height: MediaQuery.of(context).size.height / 12,
        width: MediaQuery.of(context).size.width,
      ),
      child: Consumer<MaderaNav>(
        builder: (_, mN, child) => AppBar(
          primary: true,
          elevation: cTheme.Dimens.appBarElevation,
          backgroundColor: cTheme.Colors.appBarMainColor,
          iconTheme: IconThemeData(
            color: Color.fromRGBO(39, 72, 0, 1.0),
          ),
          leading: mN.pageIndex == -1 ? ExitButton() : null,
          title: Text(
            mN.pageTitle,
            style: cTheme.TextStyles.appBarTitle,
          ),
          centerTitle: false,
          actions: <Widget>[
            mN.pageIndex !=
                    -1 // si page login ou bug, on ne veux pas de bouton qui redirige à l'accueil
                ? FlatButton(
                    onPressed: () => _redirectToPage(context, HomePage()),
                    child: Image(
                      image: AssetImage("assets/img/logo-madera.png"),
                      //je l'ai mis dans le champ "actions" comme ça pas besoin de faire de Row dans le "title"
                    ),
                  )
                : Image(
                    image: AssetImage("assets/img/logo-madera.png"),
                    //je l'ai mis dans le champ "actions" comme ça pas besoin de faire de Row dans le "title"
                  ),
          ],
        ),
      ),
    );
  } // à la base j'essayais de mettre cette méthode dans la class MaderaNav, mais ça faisait des bugs.

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
