import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/quote.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_scaffold.dart';
import 'package:proto_madera_front/ui/pages/widgets/quote_gradient_frame.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Outil de création de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class QuoteCreation extends StatefulWidget {
  static const routeName = '/quote_create';

  @override
  _QuoteCreationState createState() => _QuoteCreationState();
}

class _QuoteCreationState extends State<QuoteCreation> {
  static final _now = DateTime.now();
  final String dateCreationProjet =
      DateTime(_now.year, _now.month, _now.day).toString().substring(0, 10);
  TextEditingController _descriptionTextController;

  final log = Logger();

  @override
  void initState() {
    super.initState();
    _descriptionTextController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionTextController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaderaScaffold.noAdd(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text('Informations générales',
                  style: cTheme.TextStyles.appBarTitle.copyWith(
                    fontSize: 32.0,
                  )),
            ),
            GradientFrame(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      MaderaCard(
                        cardWidth: cTheme.Dimens.cardSizeXSmall,
                        cardHeight: cTheme.Dimens.cardHeight,
                        labelledIcon: LabelledIcon(
                          icon: Icon(
                            Icons.calendar_today,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            "Date de création",
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        child: TextField(
                          textAlign: TextAlign.center,
                          readOnly: true,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          controller: TextEditingController(
                            text: dateCreationProjet,
                          ),
                          keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: '2019-12-14',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      MaderaCard(
                        cardWidth: cTheme.Dimens.cardSizeMedium,
                        cardHeight: cTheme.Dimens.cardHeight,
                        child: TextField(
                          maxLines: 1,
                          controller: TextEditingController(
                            text: 'ID: 2\tNom: Dupont',
                          ),
                          keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: '-1',
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
                            Icons.person,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            "Références Client",
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaderaCard(
                        cardHeight: cTheme.Dimens.cardHeight,
                        cardWidth: cTheme.Dimens.cardSizeLarge,
                        child: TextField(
                          maxLines: 1,
                          controller: TextEditingController(
                            text: '1',
                          ),
                          keyboardType: TextInputType.text,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: '100000',
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
                            Icons.info,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            "ID. Projet",
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaderaCard(
                        cardHeight: cTheme.Dimens.cardHeightLarge,
                        cardWidth: cTheme.Dimens.cardSizeLarge,
                        child: TextField(
                          maxLines: 25,
                          controller: _descriptionTextController,
                          keyboardType: TextInputType.multiline,
                          enabled: true,
                          decoration: InputDecoration(
                            hintText: 'Rentrez la description du projet ici',
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
                            Icons.info,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            "Description Projet",
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaderaButton(
                        onPressed: _descriptionTextController.text.isNotEmpty
                            ? () {
                                log.d(_descriptionTextController.text);
                                log.d("Quote Creation");
                                Provider.of<MaderaNav>(context)
                                    .redirectToPage(context, Quote());
                              }
                            : null,
                        child: LabelledIcon(
                          mASize: MainAxisSize.min,
                          icon: Icon(Icons.check),
                          text: Text("Valider"),
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
    );
  }
}
