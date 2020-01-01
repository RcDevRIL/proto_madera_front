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
/// Page de "Edition de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class Quote extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  final log = Logger();
  String dropdownGammeValue;
  String dropdownModeleValue;
  bool canValidateForm;

  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
    dropdownGammeValue = '';
    canValidateForm = false;
  }

  //added to prepare for scaling
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments;
    final moduleList = Provider.of<ProviderProjet>(context).productModules;
    moduleList.isNotEmpty ? canValidateForm = true : canValidateForm = false;
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
                      value: dropdownGammeValue.isEmpty
                          ? null
                          : dropdownGammeValue,
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
                        switch (dropdownGammeValue) {
                          case 'Gamme1':
                            Provider.of<ProviderProjet>(context)
                                .setGamme(dropdownGammeValue);
                            Provider.of<ProviderProjet>(context)
                                .setModeleListFromGammeID(1);
                            break;
                          case 'Gamme2':
                            Provider.of<ProviderProjet>(context)
                                .setGamme(dropdownGammeValue);
                            Provider.of<ProviderProjet>(context)
                                .setModeleListFromGammeID(2);
                            break;
                          default:
                            {}
                            break;
                        }
                        canValidateForm = true;
                      },
                      items: <String>['Gamme1', 'Gamme2', 'Gamme3', 'Gamme4']
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
                      value: dropdownModeleValue,
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
                      onChanged: dropdownGammeValue.isNotEmpty
                          ? (String newValue) {
                              dropdownModeleValue = newValue;
                              switch (dropdownModeleValue) {
                                case 'Modele1':
                                  Provider.of<ProviderProjet>(context)
                                      .setModel(dropdownModeleValue);
                                  Provider.of<ProviderProjet>(context)
                                      .setModuleListFromModelID(1);
                                  break;
                                case 'Modele2':
                                  Provider.of<ProviderProjet>(context)
                                      .setModel(dropdownModeleValue);
                                  Provider.of<ProviderProjet>(context)
                                      .setModuleListFromModelID(2);
                                  break;
                                default:
                                  {}
                                  break;
                              }
                              canValidateForm = true;
                            }
                          : null,
                      items: Provider.of<ProviderProjet>(context)
                          .modeleList
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaCard(
                    cardHeight: MediaQuery.of(context).size.height / 3.2,
                    child: Stack(
                      children: <Widget>[
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: moduleList.length,
                          itemBuilder: (c, i) => Material(
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: cTheme.MaderaColors.maderaBlueGreen,
                              child: ListTile(
                                title: Text(moduleList[i]),
                              ),
                              onTap: () {
                                log.d("Modifying module...");
                                Provider.of<MaderaNav>(context)
                                    .redirectToPage(context, AddModule());
                              },
                            ),
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
                                  .redirectToPage(context, AddModule());
                            },
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
                      color: canValidateForm
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: canValidateForm
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  tooltip: "Valider produit",
                  onPressed: canValidateForm
                      ? () {
                          log.d('Saving form...');
                          Provider.of<ProviderProjet>(context).saveQ(
                              dropdownGammeValue,
                              dropdownModeleValue ??= 'NOPE',
                              moduleList);
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
