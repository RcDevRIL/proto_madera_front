import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show ProductCreation, AddModule;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show GradientFrame, MaderaRoundedBox, MaderaScaffold;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page to provide user some option on the module finitions
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class Finishings extends StatefulWidget {
  static const routeName = '/finishModule';

  @override
  _FinishingsState createState() => _FinishingsState();
}

class _FinishingsState extends State<Finishings> {
  final log = Logger();
  String finitionInterieure;
  String finitionExterieure;

  @override
  void initState() {
    super.initState();
    finitionInterieure = 'Finition 1';
    finitionExterieure = 'Finition 2';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerProjet = Provider.of<ProviderProjet>(context);
    return MaderaScaffold(
      passedContext: context,
      //TODO alimenter les listes de finitions !
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Finitions du module',
              style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                fontSize: 32.0,
              ),
            ),
            GradientFrame(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Finitions intérieures',
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        indent: MediaQuery.of(context).size.width / 8,
                        endIndent: MediaQuery.of(context).size.width / 8,
                        thickness: 1.0,
                      ),
                      MaderaRoundedBox(
                        edgeInsetsPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 0.0,
                        ),
                        edgeInsetsMargin: EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 10.0,
                        ),
                        boxWidth: MediaQuery.of(context).size.width / 2.7,
                        boxHeight: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Alimentée avec les finitions possibles du Module
                          children: <Widget>[
                            RadioListTile<String>(
                              //TODO rajouter ligne finition actuelle
                              title: const Text(
                                  'Finition 1 avec un texte super méga long'),
                              value: 'Finition 1',
                              groupValue: finitionInterieure,
                              onChanged: (String val) {
                                setState(() {
                                  finitionInterieure = val;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Finition 2'),
                              value: 'Finition 2',
                              groupValue: finitionInterieure,
                              onChanged: (String val) {
                                setState(() {
                                  finitionInterieure = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'Finitions extérieures',
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                          fontSize: 20.0,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        indent: MediaQuery.of(context).size.width / 8,
                        endIndent: MediaQuery.of(context).size.width / 8,
                        thickness: 1.0,
                      ),
                      MaderaRoundedBox(
                        edgeInsetsPadding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 0.0,
                        ),
                        edgeInsetsMargin: EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 10.0,
                        ),
                        boxWidth: MediaQuery.of(context).size.width / 2.7,
                        boxHeight: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // Alimentée avec les finitions possibles du Module
                          children: <Widget>[
                            RadioListTile<String>(
                              //TODO rajouter ligne finition actuelle
                              title: const Text(
                                  'Finition 1 avec un texte super méga long'),
                              value: 'Finition 1',
                              groupValue: finitionExterieure,
                              onChanged: (String val) {
                                setState(() {
                                  finitionExterieure = val;
                                });
                              },
                            ),
                            RadioListTile<String>(
                              title: const Text('Finition 2'),
                              value: 'Finition 2',
                              groupValue: finitionExterieure,
                              onChanged: (String val) {
                                setState(() {
                                  finitionExterieure = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      stackAdditions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(Provider.of<ProviderSize>(context).floatingButtonWidth,
              Provider.of<ProviderSize>(context).mediaHeight / 6, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  tooltip: 'Valider finition',
                  onPressed: () {
                    log.d('Adding Finishings...');
                    //TODO Changer les composants de finitions du module
                    providerProjet.updateListProduitModuleProjet();
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, ProductCreation(), null);
                  },
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
                  tooltip: 'Annuler',
                  onPressed: () {
                    log.d('Canceling finishings, going back...');
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, AddModule(), null);
                  },
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
