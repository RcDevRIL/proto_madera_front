import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show ExitButton;
import 'package:proto_madera_front/ui/pages/pages.dart' show HomePage;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Widget personnalisé pour une "AppBar" personnalisée
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
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
                    onPressed: () => mN.redirectToPage(context, HomePage()),
                    child: Image(
                      image: AssetImage("assets/img/logo-madera.png"),
                    ),
                  )
                : Image(
                    image: AssetImage("assets/img/logo-madera.png"),
                  ),
          ],
        ),
      ),
    );
  }
}
