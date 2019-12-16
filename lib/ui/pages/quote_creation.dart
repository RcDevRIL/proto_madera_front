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
  static var _now = DateTime.now();
  final String dateCreationProjet = _now.year.toString() +
      "-" +
      _now.month.toString() +
      "-" +
      _now.day.toString();
  TextEditingController _descriptionTextController;

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
    _descriptionTextController = TextEditingController();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    _descriptionTextController?.dispose();
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
                padding: EdgeInsets.fromLTRB(
                  cTheme.Dimens.drawerMinWitdh,
                  MediaQuery.of(context).size.height / 12,
                  0,
                  0,
                ),
                child: InkWell(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Center(
                    child: Container(
                      width: cTheme.Dimens.containerWidth,
                      height: cTheme.Dimens.containerHeight,
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
                      padding: EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text('Informations générales',
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 32.0,
                                  )),
                            ),
                            SizedBox(height: 30.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                MaderaCard(
                                  cardWidth: cTheme.Dimens.cardSizeSmall,
                                  cardHeight: cTheme.Dimens.cardHeight,
                                  enable: false,
                                  textInputType: TextInputType.text,
                                  autoText: dateCreationProjet,
                                  defaultText: '2019-12-14',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "Date de \ncréation",
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
                                  autoText: 'ID: 2\tNom: Dupont',
                                  defaultText: '-1',
                                  labelledIcon: LabelledIcon(
                                    icon: Icon(
                                      Icons.person,
                                      color: cTheme.Colors.appBarTitle,
                                    ),
                                    text: Text(
                                      "Références Client",
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
                                  maxLine: 25,
                                  textEditingController:
                                      _descriptionTextController,
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
                                    onPressed: _descriptionTextController
                                            .text.isNotEmpty
                                        ? () {
                                            log.d(_descriptionTextController
                                                .text);
                                            log.d("Quote Creation");
                                            Provider.of<MaderaNav>(context)
                                                .redirectToPage(
                                                    context, Quote());
                                          }
                                        : null,
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
