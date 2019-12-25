import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote, AddModule;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show GradientFrame, MaderaRoundedBox, MaderaScaffold;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Finitions"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class Finishings extends StatefulWidget {
  static const routeName = '/quote_create';

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
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text('Choisir une finition',
                  style: cTheme.TextStyles.appBarTitle.copyWith(
                    fontSize: 32.0,
                  )),
            ),
            GradientFrame(
              child: SingleChildScrollView(
                child: MaderaRoundedBox(
                  edgeInsetsPadding: EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  edgeInsetsMargin: EdgeInsets.symmetric(
                    horizontal: 250.0,
                    vertical: 4.0,
                  ),
                  boxWidth: 150,
                  boxHeight: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    log.d("Adding Finishings...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, Quote());
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
                    log.d("Canceling finishings, going back...");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, AddModule());
                  },
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
