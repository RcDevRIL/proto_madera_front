import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page 'Outil de création de devis'
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
                style: cTheme.TextStyles.appBarTitle.copyWith(
                  fontSize: 32.0,
                )),
            GradientFrame(
              child: ListView(
                controller: _formScrollController,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaderaCard(
                        cardWidth: cTheme.Dimens.cardSizeXSmall,
                        cardHeight: cTheme.Dimens.cardHeight,
                        header: LabelledIcon(
                          icon: Icon(
                            Icons.calendar_today,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            'Date de création',
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
                        cardWidth: cTheme.Dimens.cardSizeXSmall,
                        cardHeight: cTheme.Dimens.cardHeight,
                        child: TextField(
                          textAlign: TextAlign.center,
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
                        header: LabelledIcon(
                          icon: Icon(
                            Icons.info,
                            color: cTheme.Colors.appBarTitle,
                          ),
                          text: Text(
                            'ID. Projet',
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      // MaderaCard(
                      //   cardWidth: cTheme.Dimens.cardSizeMedium,
                      //   cardHeight: cTheme.Dimens.cardHeight,
                      //   child: TextField(
                      //     maxLines: 1,
                      //     controller: _clientDescriptionTextController,
                      //     onChanged: (text) {
                      //       setState(() {
                      //         if (text.isNotEmpty) {
                      //           Provider.of<ProviderProjet>(context)
                      //               .setRefClient(text);
                      //           canValidateForm = true;
                      //         } else {
                      //           canValidateForm = false;
                      //         }
                      //       });
                      //     },
                      //     keyboardType: TextInputType.text,
                      //     enabled: true,
                      //     decoration: InputDecoration(
                      //       hintText: '-1',
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(20.0),
                      //           bottomLeft: Radius.circular(20.0),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   labelledIcon: LabelledIcon(
                      //     icon: Icon(
                      //       Icons.person,
                      //       color: cTheme.Colors.appBarTitle,
                      //     ),
                      //     text: Text(
                      //       'Références Client',
                      //       style: cTheme.TextStyles.appBarTitle.copyWith(
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.w900,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MaderaCard(
                        cardWidth: MediaQuery.of(context).size.width / 2.4,
                        cardHeight: cTheme.Dimens.cardHeightMedium,
                        header: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text(
                            'Identification',
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: LabelledIcon(
                                icon: Icon(
                                  Icons.person,
                                  color: cTheme.Colors.appBarTitle,
                                ),
                                text: Text(
                                  'Nom ou Raison Sociale',
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              enabled: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Ex: DUPONT Nicolas',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: LabelledIcon(
                                icon: Icon(
                                  Icons.home,
                                  color: cTheme.Colors.appBarTitle,
                                ),
                                text: Text(
                                  'Adresse client',
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              // onChanged: (text) {
                              //   setState(() {
                              //     if (text.isNotEmpty) {
                              //       Provider.of<ProviderProjet>(context)
                              //           .setRefClient(text);
                              //       canValidateForm = true;
                              //     } else {
                              //       canValidateForm = false;
                              //     }
                              //   });
                              // },
                              keyboardType: TextInputType.text,
                              enabled: true,
                              decoration: InputDecoration(
                                hintText: 'Rue complète, CP, ville',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaderaCard(
                        cardWidth: MediaQuery.of(context).size.width / 3,
                        cardHeight: cTheme.Dimens.cardHeightMedium,
                        header: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Text(
                            'Contacts',
                            style: cTheme.TextStyles.appBarTitle.copyWith(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        child: ListView(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: LabelledIcon(
                                icon: Icon(
                                  Icons.phone,
                                  color: cTheme.Colors.appBarTitle,
                                ),
                                text: Text(
                                  'Téléphone',
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              // onChanged: (text) {
                              //   setState(() {
                              //     if (text.isNotEmpty) {
                              //       Provider.of<ProviderProjet>(context)
                              //           .setRefClient(text);
                              //       canValidateForm = true;
                              //     } else {
                              //       canValidateForm = false;
                              //     }
                              //   });
                              // },
                              keyboardType: TextInputType.phone,
                              enabled: true,
                              decoration: InputDecoration(
                                hintText: 'Téléphone...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: LabelledIcon(
                                icon: Icon(
                                  Icons.mail,
                                  color: cTheme.Colors.appBarTitle,
                                ),
                                text: Text(
                                  'Adresse mail',
                                  style: cTheme.TextStyles.appBarTitle.copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              // onChanged: (text) {
                              //   setState(() {
                              //     if (text.isNotEmpty) {
                              //       Provider.of<ProviderProjet>(context)
                              //           .setRefClient(text);
                              //       canValidateForm = true;
                              //     } else {
                              //       canValidateForm = false;
                              //     }
                              //   });
                              // },
                              keyboardType: TextInputType.emailAddress,
                              enabled: true,
                              decoration: InputDecoration(
                                hintText: 'Adresse mail...',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MaderaCard(
                    cardHeight: cTheme.Dimens.cardHeightLarge,
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
                    header: LabelledIcon(
                      icon: Icon(
                        Icons.info,
                        color: cTheme.Colors.appBarTitle,
                      ),
                      text: Text(
                        'Description Projet',
                        style: cTheme.TextStyles.appBarTitle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
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
                          log.d('Saving form...');
                          Provider.of<ProviderProjet>(context).saveQC(
                              dateCreationProjet,
                              _descriptionTextController.text,
                              _idProjectTextController.text,
                              _clientDescriptionTextController.text);
                          log.d('Done.');
                          log.d('Quote Creation');
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
