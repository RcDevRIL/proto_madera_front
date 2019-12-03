import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/quote.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Outil de création de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class QuoteCreation extends StatefulWidget {
  static const routeName = '/quote_create';

  @override
  _QuoteCreationState createState() => _QuoteCreationState();
}

class _QuoteCreationState extends State<QuoteCreation> {
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
                  child: Consumer<MaderaNav>(
                    builder: (context, mN, w) => Container(
                      width: cTheme.Dimens.containerWidth,
                      height: cTheme.Dimens.containerHeight,
                      color: cTheme.Colors.containerBackground,
                      child: Container(
                        width: 200,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: MaderaButton(
                            onPressed: () {
                              log.d("Quote Creation");
                              Provider.of<MaderaNav>(context)
                                  .redirectToPage(context, Quote());
                            },
                            child: LabelledIcon(
                              mASize: MainAxisSize.min,
                              icon: Icon(Icons.check),
                              text: Text("Valider"),
                            ),
                          ),
                        ),
                      ),
                      // child: RaisedButton(
                      //   onPressed: () {},
                      //   child: LabelledIcon(
                      //     icon: Icon(Icons.check),
                      //     text: Text("FDP"),
                      //   ),
                      // ),
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
