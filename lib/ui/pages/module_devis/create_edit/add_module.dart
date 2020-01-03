import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Ajout de module"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class AddModule extends StatefulWidget {
  static const routeName = '/add_module';

  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  final dataKey = GlobalKey();
  final log = Logger();
  String dropdownValue = 'Sélectionnez une nature de module...';
  TextEditingController _nameTextController;
  TextEditingController _sizeTextController;
  TextEditingController _widthTextController;
  ScrollController _formScrollController;
  String useCase;

  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _sizeTextController = TextEditingController();
    _widthTextController = TextEditingController();
    _formScrollController = ScrollController();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    _nameTextController?.dispose();
    _widthTextController?.dispose();
    _sizeTextController?.dispose();
    _formScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerProjet = Provider.of<ProviderProjet>(context);
    if (providerProjet.editModuleIndex !=
        providerProjet.productModules.length - 1) {
      useCase = 'Modifier';
      _nameTextController.text = providerProjet.productModules.entries
          .elementAt(providerProjet.editModuleIndex)
          .value['name'];
      dropdownValue = providerProjet.productModules.entries
          .elementAt(providerProjet.editModuleIndex)
          .value['nature'];
    } else
      useCase = 'Ajouter';

    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('$useCase un module',
                style: cTheme.MaderaTextStyles.appBarTitle
                    .copyWith(fontSize: 32.0)),
            GradientFrame(
              child: SingleChildScrollView(
                controller: _formScrollController,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            MaderaRoundedBox(
                              boxHeight: cTheme.Dimens.boxHeight,
                              boxWidth: 450.0,
                              edgeInsetsPadding: EdgeInsets.all(8.0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text('$dropdownValue'),
                                icon: Icon(Icons.arrow_drop_down,
                                    color:
                                        cTheme.MaderaColors.maderaLightGreen),
                                iconSize: 35,
                                elevation: 16,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(fontSizeDelta: -4),
                                underline: Container(
                                  height: 2,
                                  width: 100.0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (String newValue) {
                                  log.i('OLD: ' +
                                      providerProjet.productModules.values
                                          .elementAt(providerProjet
                                              .editModuleIndex)['nature']);
                                  providerProjet.updateModuleNature(newValue);
                                  log.i('NEW: ' +
                                      providerProjet.productModules.values
                                          .elementAt(providerProjet
                                              .editModuleIndex)['nature']);
                                  setState(() {
                                    dropdownValue = newValue;
                                    _nameTextController.text = newValue + ' - ';
                                  });
                                },
                                items: <String>[
                                  'Mur droit',
                                  'Mur avec angle entrant',
                                  'Mur avec angle entrant',
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
                            SizedBox(height: 10.0),
                            MaderaCard(
                              cardWidth: 450.0,
                              cardHeight: cTheme.Dimens.cardHeight,
                              child: TextField(
                                maxLines: 1,
                                keyboardType: TextInputType.text,
                                controller: _nameTextController,
                                onChanged: (text) {
                                  providerProjet.productModules.values
                                      .elementAt(providerProjet.editModuleIndex)
                                      .update(
                                        'name',
                                        (old) => text,
                                        () => text,
                                      );
                                },
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
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.text_fields,
                                  color: cTheme.MaderaColors.textHeaderColor,
                                ),
                                text: Text(
                                  "Nom du module",
                                  style: cTheme.MaderaTextStyles.appBarTitle
                                      .copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    providerProjet.productModules.values.elementAt(
                                providerProjet.editModuleIndex)['nature'] ==
                            'Mur droit'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MaderaCard(
                                cardHeight: cTheme.Dimens.cardHeight,
                                cardWidth: 450.0,
                                header: LabelledIcon(
                                  // TODO: Trouver une meilleure icone, genre règle et équerre
                                  icon: Icon(Icons.open_with),
                                  text: Text("Section (en centimètres)"),
                                ),
                                child: TextField(
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  enabled: true,
                                  controller: _widthTextController,
                                  decoration: InputDecoration(
                                    hintText: 'Section...',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    /* 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaderaCard(
                          cardHeight: cTheme.Dimens.cardHeight,
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Angle entrant (en degrés)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: 'Angle...',
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
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Section (en centimètres)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: 'Section...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ), */ /* 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaderaCard(
                          cardHeight: cTheme.Dimens.cardHeight,
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Longueur (en mètres)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
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
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Angle sortant (en degrés)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: 'Angle...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ), */
                    /* Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaderaCard(
                          cardHeight: cTheme.Dimens.cardHeight,
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Section (en centimètres)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: 'Section...',
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
                          cardWidth: 450.0,
                          labelledIcon: LabelledIcon(
                            // TODO: Trouver une meilleure icone, genre règle et équerre
                            icon: Icon(Icons.open_with),
                            text: Text("Longueur (en mètres)"),
                          ),
                          child: TextField(
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
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
                      ],
                    ), */
                    SizedBox(height: 300),
                    Container(
                      child: Column(
                        children:
                            _buildInputFieldsByModuleNature(dropdownValue),
                      ),
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
                      color: providerProjet.isFilled('AddModule')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('AddModule')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: providerProjet.isFilled('AddModule')
                      ? () {
                          log.d("Validating Module...");
                          providerProjet.updateModuleInfos({
                            'name': _nameTextController.text,
                            'nature': dropdownValue,
                            'section': _sizeTextController.text,
                          });
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Finishings());
                        }
                      : null,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: providerProjet.isFilled('AddModule')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('AddModule')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: providerProjet.isFilled('AddModule')
                      ? () {
                          log.d("Canceling Module...");
                          providerProjet.productModules.remove(providerProjet
                              .productModules.keys
                              .elementAt(providerProjet.editModuleIndex));
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Quote());
                        }
                      : null,
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
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

List<Widget> _buildInputFieldsByModuleNature(String natureModule) {
  return <Widget>[];
}
