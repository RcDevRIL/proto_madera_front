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
  String dropdownModuleValue = 'Sélectionnez un module...';
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
    final componentsList =
        Provider.of<ProviderProjet>(context).moduleComponents;
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
                'Projet',
                style: cTheme.TextStyles.appBarTitle.copyWith(fontSize: 32.0),
              ),
            ),
            GradientFrame(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shrinkWrap: true,
                children: <Widget>[
                  MaderaRoundedBox(
                    boxHeight: cTheme.Dimens.boxHeight,
                    boxWidth: cTheme.Dimens.boxWidth,
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
                          Provider.of<ProviderProjet>(context)
                              .setGamme(dropdownGammeValue);
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
                  SizedBox(height: 15.0),
                  MaderaRoundedBox(
                    boxWidth: cTheme.Dimens.boxWidth,
                    boxHeight: cTheme.Dimens.boxHeight,
                    child: DropdownButton<String>(
                      value: Provider.of<ProviderProjet>(context).module.isEmpty
                          ? null
                          : Provider.of<ProviderProjet>(context).module,
                      isExpanded: true,
                      hint: Text('$dropdownModuleValue'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.Colors.containerBackgroundLinearStart),
                      iconSize: 20,
                      elevation: 16,
                      style: TextStyle(color: cTheme.Colors.appBarTitle),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownModuleValue = newValue;
                          switch (dropdownModuleValue) {
                            case 'Module1':
                              Provider.of<ProviderProjet>(context)
                                  .setModule(dropdownModuleValue);
                              Provider.of<ProviderProjet>(context)
                                  .getComponentFromModuleId(1);
                              break;
                            case 'Module2':
                              Provider.of<ProviderProjet>(context)
                                  .setModule(dropdownModuleValue);
                              Provider.of<ProviderProjet>(context)
                                  .getComponentFromModuleId(2);
                              break;
                            default:
                              {}
                              break;
                          }
                          canValidateForm = true;
                        });
                      },
                      items: <String>[
                        'Module1',
                        'Module2',
                        'Module3',
                        'Module4'
                      ]
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
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
                          itemCount: componentsList.length,
                          itemBuilder: (c, i) => ListTile(
                            title: Text(componentsList[i]),
                          ),
                          separatorBuilder: (c, i) => Divider(
                            color: Colors.green,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaderaButton(
                            onPressed: () {
                              log.d("Adding Component for this quote");
                              Provider.of<MaderaNav>(context)
                                  .redirectToPage(context, AddModule());
                            },
                            child: LabelledIcon(
                              icon: Icon(Icons.add),
                              text: Text("Ajouter composant"),
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
                      text: Text('Liste des composants'),
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
                  onPressed: canValidateForm
                      ? () {
                          log.d("Quote Overview");
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
