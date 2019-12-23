import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote, AddModule;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
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
  bool canValidateForm;

  @override
  void initState() {
    super.initState();
    canValidateForm = false;
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
              child: Text('Finitions',
                  style: cTheme.TextStyles.appBarTitle.copyWith(
                    fontSize: 32.0,
                  )),
            ),
            GradientFrame(
              child: SingleChildScrollView(
                child: Column(),
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
                          log.d("Adding Finishings...");
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Quote());
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
