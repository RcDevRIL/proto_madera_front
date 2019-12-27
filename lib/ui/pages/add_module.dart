import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote, Finishings;

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:provider/provider.dart';

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
  String dropdownValue = 'One';

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
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text("Ajouter un module",
                  style:
                      cTheme.TextStyles.appBarTitle.copyWith(fontSize: 32.0)),
            ),
            GradientFrame(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            MaderaCard(
                              cardWidth: 350.0,
                              cardHeight: 45.0,
                              child: TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                enabled: true,
                                decoration: InputDecoration(
                                  hintText: 'Nom du module...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
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
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            MaderaRoundedBox(
                              boxWidth: 350.0,
                              boxHeight: 45.0,
                              edgeInsetsPadding:
                                  EdgeInsets.symmetric(horizontal: 8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text('$dropdownValue'),
                                icon: Icon(Icons.arrow_drop_down,
                                    color: cTheme
                                        .Colors.containerBackgroundLinearStart),
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
                                // TODO: Trouver une meilleure icone pour représenter une taille.
                                // category / open_with / change_history
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      stackAdditions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              1200, MediaQuery.of(context).size.height / 6, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: cTheme.Colors.containerBackgroundLinearStart,
                      width: 2),
                  color: cTheme.Colors.containerBackgroundLinearEnd,
                ),
                child: IconButton(
                  onPressed: () {
                    log.d("Validating Module...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, Finishings());
                  },
                  icon: Icon(
                    Icons.check,
                    color: cTheme.Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: cTheme.Colors.containerBackgroundLinearStart,
                        width: 2),
                    color: cTheme.Colors.containerBackgroundLinearEnd),
                child: IconButton(
                  onPressed: () {
                    log.d("Canceling Module...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, Quote());
                  },
                  icon: Icon(
                    Icons.clear,
                    color: cTheme.Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
