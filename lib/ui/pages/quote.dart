import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/add_module.dart';
import 'package:proto_madera_front/ui/pages/quote_overview.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_box.dart';
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
                child: InkWell(
                  focusColor: Colors.transparent,
                  onTap: () => FocusScope.of(context).unfocus(),
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
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text('Projet',
                                style: cTheme.TextStyles.appBarTitle.copyWith(
                                  fontSize: 32.0
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MaderaBox(
                                boxHeight: cTheme.Dimens.boxHeight,
                                boxWidth: cTheme.Dimens.boxWidth,
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: dropdownValue,
                                    hint: Center(child: Text(dropdownValue)),
                                    icon: Icon(Icons.arrow_drop_down, color: cTheme.Colors.containerBackgroundLinearStart),
                                    iconSize: 20,
                                    elevation: 16,
                                    style:
                                        TextStyle(color: cTheme.Colors.appBarTitle),
                                    underline: Container(
                                      height: 2,
                                      width: 100.0,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String newValue) {
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['One', 'Two', 'Free', 'Four']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) =>
                                                DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
                                        .toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: MaderaBox(
                                boxWidth: cTheme.Dimens.boxWidth,
                                boxHeight: cTheme.Dimens.boxHeight,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  hint: Center(child: Text(dropdownValue)),
                                  icon: Icon(Icons.arrow_drop_down, color: cTheme.Colors.containerBackgroundLinearStart),
                                  iconSize: 20,
                                  elevation: 16,
                                  style:
                                      TextStyle(color: cTheme.Colors.appBarTitle),
                                  underline: Container(
                                    color: Colors.transparent,
                                  ),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      dropdownValue = newValue;
                                    });
                                  },
                                  items: <String>['One', 'Two', 'Free', 'Four']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) =>
                                              DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              ))
                                      .toList(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45.0,
                            ),
                            MaderaCard(
                              cardHeight: cTheme.Dimens.cardHeightLarge,
                              cardWidth: cTheme.Dimens.cardSizeLarge,
                              child: Stack(
                                children: <Widget>[
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (c, i) => ListTile(
                                      title: Text('Item n°$i'),
                                    ),
                                    separatorBuilder: (c, i) => Divider(
                                      color: Colors.green,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: MaderaButton(
                                      onPressed: () {
                                        log.d("Adding Module for this quote");
                                        Provider.of<MaderaNav>(context)
                                            .redirectToPage(
                                                context, AddModule());
                                      },
                                      child: LabelledIcon(
                                        icon: Icon(Icons.add),
                                        text: Text("Ajouter module"),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              labelledIcon: LabelledIcon(
                                icon: Icon(
                                  Icons.format_list_bulleted,
                                  color: cTheme.Colors.appBarTitle,
                                ),
                                text: Text('Liste des modules'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(1200, MediaQuery.of(context).size.height / 7, 0, 0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cTheme.Colors.containerBackgroundLinearStart, width: 2),
                        color: cTheme.Colors.containerBackgroundLinearEnd
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.check, color: cTheme.Colors.white,),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: cTheme.Colors.containerBackgroundLinearStart, width: 2),
                        color: cTheme.Colors.containerBackgroundLinearEnd
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: cTheme.Colors.white,),
                      ),
                    )
                  ],
                )
              ),
              // Align(
              //   alignment: Alignment.topRight,
              //   child: Padding(
              //     padding: const EdgeInsets.fromLTRB(0, cTheme.Dimens.appBarElevation,
              //         0,
              //         0),
              //     child: MaderaButton(
              //       onPressed: () {
              //         log.d("Validating Quote");
              //         Provider.of<MaderaNav>(context)
              //             .redirectToPage(context, QuoteOverview());
              //       },
              //       child: LabelledIcon(
              //         icon: Icon(Icons.check),
              //         text: Text("Valider le devis"),
              //       ),
              //     ),
              //   ),
              // ),
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
