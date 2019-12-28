import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AddModule, QuoteOverview;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page de "Edition de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class Quote extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  final log = Logger();
  String dropdownGammeValue = 'Sélectionnez une gamme...';
  String dropdownModeleValue = 'Sélectionnez un modèle...';
  bool canValidateForm;

  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
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
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Produit n°1', //TODO implémenter getProductNumber dans Provider Projet
                style: cTheme.TextStyles.appBarTitle.copyWith(fontSize: 32.0),
              ),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  MaderaCard(
                    cardWidth: MediaQuery.of(context).size.width / 2,
                    cardHeight: 45.0,
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
                    labelledIcon: LabelledIcon(
                      icon: Icon(
                        Icons.text_fields,
                        color: cTheme.Colors.appBarTitle,
                      ),
                      text: Text(
                        "Nom du produit",
                        style: cTheme.TextStyles.appBarTitle.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxHeight: cTheme.Dimens.boxHeight,
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    edgeInsetsMargin: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: Provider.of<ProviderProjet>(context).gamme.isEmpty
                          ? null
                          : Provider.of<ProviderProjet>(context).gamme,
                      hint: Text('$dropdownGammeValue'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.Colors.containerBackgroundLinearStart),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: cTheme.Colors.appBarTitle),
                      underline: Container(
                        height: 2,
                        width: 100.0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownGammeValue = newValue;
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
                        });
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
                      value: Provider.of<ProviderProjet>(context).model.isEmpty
                          ? null
                          : Provider.of<ProviderProjet>(context).model,
                      isExpanded: true,
                      hint: Text('$dropdownModeleValue'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.Colors.containerBackgroundLinearStart),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: cTheme.Colors.appBarTitle),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: dropdownGammeValue.isNotEmpty
                          ? (String newValue) {
                              setState(() {
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
                              });
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
                              splashColor:
                                  cTheme.Colors.containerBackgroundLinearEnd,
                              child: ListTile(
                                title: Text(modeleList[i]),
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
                    labelledIcon: LabelledIcon(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: cTheme.Colors.appBarTitle,
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
                          ? cTheme.Colors.containerBackgroundLinearStart
                          : Colors.grey,
                      width: 2),
                  color: canValidateForm
                      ? cTheme.Colors.containerBackgroundLinearEnd
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
                              .redirectToPage(context, QuoteOverview());
                        }
                      : null,
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
                  tooltip: "Supprimer produit",
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
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
