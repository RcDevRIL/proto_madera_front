import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
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
/// @version 0.4-RELEASE
class Finishings extends StatefulWidget {
  static const routeName = '/finishModule';

  @override
  _FinishingsState createState() => _FinishingsState();
}

class _FinishingsState extends State<Finishings> {
  final log = Logger();
  String choice;

  @override
  void initState() {
    super.initState();
    choice = "Finition 1";
  }

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Finitions du module',
              style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                fontSize: 32.0,
              ),
            ),
            GradientFrame(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    boxWidth: MediaQuery.of(context).size.height / 1.3,
                    boxHeight: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Alimentée avec les finitions possibles du Module
                      children: <Widget>[
                        RadioListTile<String>(
                          title: const Text(
                              'Finition 1 avec un texte super méga long'),
                          value: 'Finition 1',
                          groupValue: choice,
                          onChanged: (String val) {
                            setState(() {
                              choice = val;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Finition 2'),
                          value: 'Finition 2',
                          groupValue: choice,
                          onChanged: (String val) {
                            setState(() {
                              choice = val;
                            });
                          },
                        ),
                      ],
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
                      color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  tooltip: "Valider finition",
                  onPressed: () {
                    log.d("Adding Finishings...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, ProductCreation());
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
                  tooltip: "Annuler",
                  onPressed: () {
                    log.d("Canceling finishings, going back...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, AddModule());
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
