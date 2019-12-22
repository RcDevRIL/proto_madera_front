import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Ajout de module"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class AddModule extends StatefulWidget {
  static const routeName = '/add_module';

  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  final log = Logger();
  String dropdownValue = 'Sélectionnez une nature de module...';

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
                              child: Text(
                                'Ajouter module',
                                style: cTheme.TextStyles.appBarTitle
                                    .copyWith(fontSize: 32.0),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    MaderaCard(
                                      cardWidth: cTheme.Dimens.boxWidthMedium,
                                      cardHeight: cTheme.Dimens.cardHeight,
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        enabled: true,
                                        decoration: InputDecoration(
                                          hintText: 'Nom du module...',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20.0),
                                              bottomLeft: Radius.circular(20.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      labelledIcon: LabelledIcon(
                                        icon: Icon(
                                          Icons.text_fields,
                                          color: cTheme.Colors.appBarTitle,
                                        ),
                                        text: Text(
                                          "Nom du module",
                                          style: cTheme.TextStyles.appBarTitle
                                              .copyWith(
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    MaderaRoundedBox(
                                      boxHeight: cTheme.Dimens.boxHeight,
                                      boxWidth: cTheme.Dimens.boxWidthMedium,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        hint: Text('$dropdownValue'),
                                        icon: Icon(Icons.arrow_drop_down,
                                            color: cTheme.Colors
                                                .containerBackgroundLinearStart),
                                        iconSize: 20,
                                        elevation: 16,
                                        style: TextStyle(
                                            color: cTheme.Colors.appBarTitle),
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
                                        items: <String>[
                                          'Nature module 1',
                                          'Nature module 2',
                                          'Nature module 3',
                                          'Nature module 4'
                                        ]
                                            .map<DropdownMenuItem<String>>(
                                                (String value) =>
                                                    DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value),
                                                    ))
                                            .toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    MaderaCard(
                                      cardHeight: cTheme.Dimens.cardHeight,
                                      cardWidth: cTheme.Dimens.cardSizeSmall,
                                      labelledIcon: LabelledIcon(
                                        // TODO: Trouver une meilleure icone, genre règle et équerre
                                        icon: Icon(Icons.open_with),
                                        text: Text("Longueur (en mètres)"),
                                      ),
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        enabled: true,
                                        decoration: InputDecoration(
                                          hintText: 'Longueur...',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                          )),
                                        ),
                                      ),
                                    ),
                                    MaderaCard(
                                      cardHeight: cTheme.Dimens.cardHeight,
                                      cardWidth: cTheme.Dimens.cardSizeSmall,
                                      labelledIcon: LabelledIcon(
                                        // TODO: Trouver une meilleure icone, genre règle et équerre
                                        icon: Icon(Icons.open_with),
                                        text: Text("Largeur (en mètres)"),
                                      ),
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.number,
                                        enabled: true,
                                        decoration: InputDecoration(
                                          hintText: 'Largeur...',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20.0),
                                            bottomLeft: Radius.circular(20.0),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                

                                // MaderaCard(
                                //   cardHeight: cTheme.Dimens.cardHeight,
                                //   cardWidth: cTheme.Dimens.cardSizeSmall,
                                //   labelledIcon: LabelledIcon(
                                //     // TODO: Trouver une meilleure icone, genre règle et équerre
                                //     icon: Icon(Icons.open_with),
                                //     text: Text("Angle entrant (en mètres)"),
                                //   ),
                                //   child: TextField(
                                //     maxLines: 1,
                                //     keyboardType: TextInputType.number,
                                //     enabled: true,
                                //     decoration: InputDecoration(
                                //       hintText: 'Longueur...',
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.only(
                                //           bottomRight: Radius.circular(20.0),
                                //           bottomLeft: Radius.circular(20.0),
                                //         )
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // MaderaCard(
                                //   cardHeight: cTheme.Dimens.cardHeight,
                                //   cardWidth: cTheme.Dimens.cardSizeSmall,
                                //   labelledIcon: LabelledIcon(
                                //     // TODO: Trouver une meilleure icone, genre règle et équerre
                                //     icon: Icon(Icons.open_with),
                                //     text: Text("Longueur (en mètres)"),
                                //   ),
                                //   child: TextField(
                                //     maxLines: 1,
                                //     keyboardType: TextInputType.number,
                                //     enabled: true,
                                //     decoration: InputDecoration(
                                //       hintText: 'Longueur...',
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.only(
                                //           bottomRight: Radius.circular(20.0),
                                //           bottomLeft: Radius.circular(20.0),
                                //         )
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
