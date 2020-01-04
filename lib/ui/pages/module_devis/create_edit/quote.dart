import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AddModule, ProductList;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Product creation page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class ProductCreation extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _ProductCreationState createState() => _ProductCreationState();
}

class _ProductCreationState extends State<ProductCreation> {
  final log = Logger();
  String dropdownGammeValue;
  String dropdownModeleValue;
  bool canValidateForm;

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
    var providerProjet = Provider.of<ProviderProjet>(context);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Produit n°1', //TODO implémenter getProductNumber dans Provider Projet
              style:
                  cTheme.MaderaTextStyles.appBarTitle.copyWith(fontSize: 32.0),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  MaderaCard(
                    cardWidth: MediaQuery.of(context).size.width / 2,
                    cardHeight: 40.0,
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      enabled: true,
                      controller: TextEditingController(
                        text: providerProjet.nomDeProduit,
                      ),
                      onChanged: (text) {
                        providerProjet.setNomDeProduit(text);
                      },
                      decoration: InputDecoration(
                        hintText: 'Nom du produit...',
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
                        "Nom du produit",
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxHeight: 55,
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    edgeInsetsMargin: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: providerProjet.gamme,
                      hint: Text('Sélectionnez une gamme...'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        dropdownGammeValue = newValue;
                        dropdownModeleValue = null;
                        switch (newValue) {
                          case 'Premium':
                            providerProjet.setGamme(newValue);
                            providerProjet.setModeleListFromGammeID(1);
                            break;
                          case 'Standard':
                            providerProjet.setGamme(newValue);
                            providerProjet.setModeleListFromGammeID(2);
                            break;
                          default:
                            {}
                            break;
                        }
                      },
                      items: <String>[
                        'Premium',
                        'Standard',
                        'Gamme3',
                        'Gamme4',
                      ]
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    boxHeight: cTheme.Dimens.boxHeight,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: providerProjet.model,
                      hint: Text('Sélectionnez un modèle...'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: providerProjet.gamme != null
                          ? (String newValue) {
                              dropdownModeleValue = newValue;
                              switch (dropdownModeleValue) {
                                case 'Modèle Premium 1':
                                  providerProjet.setModel(dropdownModeleValue);
                                  providerProjet.setModuleListFromModelID(1);
                                  break;
                                case 'Modèle Premium 2':
                                  providerProjet.setModel(dropdownModeleValue);
                                  providerProjet.setModuleListFromModelID(2);
                                  break;
                                default:
                                  {}
                                  break;
                              }
                            }
                          : null,
                      items: providerProjet.modeleList.length != 0
                          ? providerProjet.modeleList.keys
                              .map<DropdownMenuItem<String>>(
                                  (String value) => DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      ))
                              .toList()
                          : null,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaCard(
                    cardHeight: MediaQuery.of(context).size.height / 3.2,
                    child: Stack(
                      children: <Widget>[
                        providerProjet.productModules != null
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    providerProjet.productModules.keys.length,
                                itemBuilder: (c, i) => Material(
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor:
                                        cTheme.MaderaColors.maderaBlueGreen,
                                    child: ListTile(
                                      title: Text(providerProjet
                                          .productModules.values
                                          .elementAt(i)['name']),
                                    ),
                                    onTap: () {
                                      log.d("Modifying module...");
                                      providerProjet.editModuleIndex = i;
                                      Provider.of<MaderaNav>(context)
                                          .redirectToPage(context, AddModule());
                                    },
                                  ),
                                ),
                                separatorBuilder: (c, i) => Divider(
                                  color: Colors.green,
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaderaButton(
                            onPressed: providerProjet.productModules != null
                                ? () {
                                    log.d("Adding Module for this quote");
                                    providerProjet.editModuleIndex =
                                        providerProjet.productModules.length;
                                    providerProjet.productModules.putIfAbsent(
                                      'untitled module',
                                      () => {
                                        'name': 'untitled module',
                                        'nature': '',
                                      },
                                    );
                                    Provider.of<MaderaNav>(context)
                                        .redirectToPage(context, AddModule());
                                  }
                                : null,
                            child: LabelledIcon(
                              icon: Icon(Icons.add),
                              text: Text("Ajouter Module"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    header: LabelledIcon(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: cTheme.MaderaColors.textHeaderColor,
                      ),
                      text: Text('Liste des Modules'),
                    ),
                  ),
                ],
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
                      color: providerProjet.productModules != null
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('Quote')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  tooltip: "Valider produit",
                  onPressed: providerProjet.isFilled('Quote')
                      ? () {
                          log.d('Saving form...');
                          providerProjet.logQ();
                          log.d('Done.');
                          log.d('Quote Overview');
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductList());
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
                        color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                    color: cTheme.MaderaColors.maderaBlueGreen),
                child: IconButton(
                  tooltip: "Supprimer produit",
                  onPressed: () {},
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
