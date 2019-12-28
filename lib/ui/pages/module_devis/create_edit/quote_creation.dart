import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page "Outil de création de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
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
  TextEditingController _clientDescriptionTextController;
  TextEditingController _idProjectTextController;
  ScrollController _formScrollController;
  bool canValidateForm;

  final log = Logger();

  @override
  void initState() {
    super.initState();
    _descriptionTextController = TextEditingController();
    _clientDescriptionTextController = TextEditingController();
    _clientDescriptionTextController.text = 'ID: 2\tNom: Dupont';
    _idProjectTextController = TextEditingController();
    _idProjectTextController.text = '454';
    _formScrollController = ScrollController();
    canValidateForm = false;
  }

  @override
  void dispose() {
    _descriptionTextController?.dispose();
    _clientDescriptionTextController?.dispose();
    _idProjectTextController?.dispose();
    _formScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderProjet>(context)
        .flush(); // Make sure providerProjet is empty
    Provider.of<ProviderProjet>(context)
        .setIdProjet(_idProjectTextController.text);
    Provider.of<ProviderProjet>(context).setDate(dateCreationProjet);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Informations générales',
                style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                  fontSize: 32.0,
                )),
            GradientFrame(
              child: SingleChildScrollView(
                controller: _formScrollController,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaderaCard(
                          cardWidth: cTheme.Dimens.cardSizeXSmall,
                          cardHeight: cTheme.Dimens.cardHeight,
                          labelledIcon: LabelledIcon(
                            icon: Icon(
                              Icons.calendar_today,
                              color: cTheme.MaderaColors.textHeaderColor,
                            ),
                            text: Text(
                              "Date de création",
                              style:
                                  cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                            controller: _clientDescriptionTextController,
                            onChanged: (text) {
                              setState(() {
                                if (text.isNotEmpty) {
                                  Provider.of<ProviderProjet>(context)
                                      .setRefClient(text);
                                  canValidateForm = true;
                                } else {
                                  canValidateForm = false;
                                }
                              });
                            },
                            keyboardType: TextInputType.text,
                            enabled: true,
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
                              color: cTheme.MaderaColors.textHeaderColor,
                            ),
                            text: Text(
                              "Références Client",
                              style:
                                  cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                            controller: _idProjectTextController,
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
                              color: cTheme.MaderaColors.textHeaderColor,
                            ),
                            text: Text(
                              "ID. Projet",
                              style:
                                  cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                            onTap: () => _formScrollController.jumpTo(
                                _formScrollController.position.maxScrollExtent),
                            maxLines: 25,
                            controller: _descriptionTextController,
                            onChanged: (text) {
                              setState(() {
                                if (text.isNotEmpty) {
                                  Provider.of<ProviderProjet>(context)
                                      .setDescription(text);
                                  canValidateForm = true;
                                } else {
                                  canValidateForm = false;
                                }
                              });
                            },
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
                              color: cTheme.MaderaColors.textHeaderColor,
                            ),
                            text: Text(
                              "Description Projet",
                              style:
                                  cTheme.MaderaTextStyles.appBarTitle.copyWith(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
                      color: canValidateForm
                          ? cTheme.MaderaColors.containerBackgroundLinearStart
                          : Colors.grey,
                      width: 2),
                  color: canValidateForm
                      ? cTheme.MaderaColors.containerBackgroundLinearEnd
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: canValidateForm
                      ? () {
                          log.d('Saving form...');
                          Provider.of<ProviderProjet>(context).saveQC(
                              dateCreationProjet,
                              _descriptionTextController.text,
                              _idProjectTextController.text,
                              _clientDescriptionTextController.text);
                          log.d('Done.');
                          log.d("Quote Creation");
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Quote());
                        }
                      : null,
                  icon: Icon(
                    Icons.check,
                    color: cTheme.MaderaColors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color:
                            cTheme.MaderaColors.containerBackgroundLinearStart,
                        width: 2),
                    color: cTheme.MaderaColors.containerBackgroundLinearEnd),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: cTheme.MaderaColors.white,
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
