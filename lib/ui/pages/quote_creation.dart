import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/quote.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Outil de création de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
/// @version 0.2-RELEASE
///
class QuoteCreation extends StatefulWidget {
  static const routeName = '/quote_create';

  @override
  _QuoteCreationState createState() => _QuoteCreationState();
}

class _QuoteCreationState extends State<QuoteCreation> {
  static var now = DateTime.now();
  final String dateCreationProjet = now.year.toString() +
      "-" +
      now.month.toString() +
      "-" +
      now.day.toString();
  final log = Logger();

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

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
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(cTheme.Dimens.drawerMinWitdh,
                    MediaQuery.of(context).size.height / 12, 0, 0),
                child: Center(
                  child: Consumer<MaderaNav>(
                    builder: (context, mN, w) => Container(
                      width: cTheme.Dimens.containerWidth,
                      height: cTheme.Dimens.containerHeight,
                      // color: cTheme.Colors.containerBackgroundLinearStart,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.grey,
                              offset: Offset(10.0, 10.0),
                            ),
                            BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.grey,
                              offset: Offset(0.0, 00.0),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [
                              cTheme.Colors.containerBackgroundLinearStart,
                              cTheme.Colors.containerBackgroundLinearEnd
                            ],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 0.0),
                          )),
                      padding: EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text("Devis",
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 32.0,
                                  )),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                MaderaCard(
                                  cardWidth: cTheme.Dimens.cardSizeSmall,
                                  cardHeight: cTheme.Dimens.cardHeight,
                                  enable: false,
                                  textInputType: TextInputType.text,
                                  autoText: dateCreationProjet,
                                  defaultText: '14/12/2019',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "Date de création",
                                      style: cTheme.TextStyles.appBarTitle
                                          .copyWith(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                MaderaCard(
                                  cardWidth: cTheme.Dimens.cardSizeMedium,
                                  cardHeight: cTheme.Dimens.cardHeight,
                                  enable: false,
                                  textInputType: TextInputType.text,
                                  autoText: '2',
                                  defaultText: '-1',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.person,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "ID. Client",
                                      style: cTheme.TextStyles.appBarTitle
                                          .copyWith(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaderaCard(
                                  cardHeight: cTheme.Dimens.cardHeight,
                                  cardWidth: cTheme.Dimens.cardSizeLarge,
                                  enable: false,
                                  textInputType: TextInputType.text,
                                  defaultText: '1',
                                  autoText: '1',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.info,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "ID. Projet",
                                      style: cTheme.TextStyles.appBarTitle
                                          .copyWith(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MaderaCard(
                                  cardHeight: cTheme.Dimens.cardHeightLarge,
                                  cardWidth: cTheme.Dimens.cardSizeLarge,
                                  enable: true,
                                  textInputType: TextInputType.multiline,
                                  maxLine: 5,
                                  defaultText:
                                      'Rentrez la description du projet ici',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.info,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "Description Projet",
                                      style: cTheme.TextStyles.appBarTitle
                                          .copyWith(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: MaderaButton(
                                    onPressed: () {
                                      log.d("Quote Creation");
                                      Provider.of<MaderaNav>(context)
                                          .redirectToPage(context, Quote());
                                    },
                                    child: LabelledIcon(
                                      mASize: MainAxisSize.min,
                                      icon: Icon(Icons.check),
                                      text: Text("Valider"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
                child: AppBarMadera(),
              ),
              CustomDrawer(),
            ],
          ),
        ),
      ),
    );
  }
}
