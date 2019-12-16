import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/add_module.dart';
import 'package:proto_madera_front/ui/pages/quote_overview.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page de "Edition de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class Quote extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  final log = Logger();
  String dropdownValue = 'One';

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
          backgroundColor: cTheme.Colors.white,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(cTheme.Dimens.drawerMinWitdh,
                    MediaQuery.of(context).size.height / 12, 0, 0),
                child: Center(
                  /** Centre de la page */
                  child: Container(
                    width: cTheme.Dimens.containerWidth,
                    height: cTheme.Dimens.containerHeight,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                            offset: Offset(10.0, 10.0),
                          ),
                          BoxShadow(
                            blurRadius: 5.0,
                            color: Colors.grey,
                            offset: Offset(0.0, 00.0),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            cTheme.Colors.containerBackgroundLinearStart,
                            cTheme.Colors.containerBackgroundLinearEnd
                          ],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 0.0),
                        )),
                    padding: EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          value: dropdownValue,
                          hint: Text(dropdownValue),
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['One', 'Two', 'Free', 'Four']
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList(),
                        ),
                        Align(
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
                      ],
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
