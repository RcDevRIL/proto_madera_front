import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/add_module.dart';
import 'package:proto_madera_front/ui/pages/quote_overview.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page de "Edition de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class Quote extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  final log = Logger();

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

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
    //final args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(cTheme.Dimens.drawerMinWitdh,
                    MediaQuery.of(context).size.height / 12, 0, 0),
                child: Center(
                  /** Centre de la page */
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: cTheme.Dimens.containerWidth,
                    height: cTheme.Dimens.containerHeight,
                    color: cTheme.Colors.containerBackground,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: MaderaButton(
                        onPressed: () {
                          log.d("Adding Module for this quote");
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, AddModule());
                        },
                        child: LabelledIcon(
                          icon: Icon(Icons.add),
                          text: Text("Ajouter module"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      0,
                      0,
                      cTheme.Dimens.buttonPaddingRight,
                      cTheme.Dimens.buttonPaddingBottom),
                  child: MaderaButton(
                    // TODO: Redirect to Quote Overview
                    onPressed: () {
                      log.d("Validating Quote");
                      Provider.of<MaderaNav>(context)
                          .redirectToPage(context, QuoteOverview());
                    },
                    child: LabelledIcon(
                      icon: Icon(Icons.check),
                      text: Text("Valider le devis"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
                child: AppBarMadera(),
              ),
              CustomDrawer(),
            ],
          ),
        ),
      ),
    );
  }
}
