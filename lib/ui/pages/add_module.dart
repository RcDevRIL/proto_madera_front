import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Ajout de module"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class AddModule extends StatefulWidget {
  static const routeName = '/add_module';

  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
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
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    MaderaCard(
                                      cardWidth: cTheme.Dimens.cardSizeSmall,
                                      cardHeight: cTheme.Dimens.cardHeight,
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        enabled: false,
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
                                    MaderaDropDown(
                                      boxHeight: cTheme.Dimens.boxHeight,
                                      boxWidth: cTheme.Dimens.boxWidth,
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        hint:
                                            Center(child: Text(dropdownValue)),
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
                                          'One',
                                          'Two',
                                          'Free',
                                          'Four'
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
