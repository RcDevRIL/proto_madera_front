import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart' show Quote;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page 'Outil de création de devis'
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class QuoteCreation extends StatefulWidget {
  static const routeName = '/quote_create';

  @override
  _QuoteCreationState createState() => _QuoteCreationState();
}

class _QuoteCreationState extends State<QuoteCreation> {
  String dateCreationProjet;
  String refProjet;
  ScrollController _formScrollController;

  final log = Logger();

  @override
  void initState() {
    super.initState();
    _formScrollController = ScrollController();
  }

  @override
  void dispose() {
    _formScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateCreationProjet = Provider.of<ProviderProjet>(context).dateCreation;
    refProjet = Provider.of<ProviderProjet>(context).refProjet;
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
                            color: cTheme.MaderaColors.textHeaderColor,
                          ),
                          text: Text(
                            'Date de création',
                            style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(dateCreationProjet),
                        ),
                      ),
                      MaderaCard(
                        cardWidth: 250.0,
                        cardHeight: cTheme.Dimens.cardHeight,
                        child: Center(
                          child: Text(dateCreationProjet + '_MMP123'),
                        ),
                        header: LabelledIcon(
                          icon: Icon(
                            Icons.info,
                            color: cTheme.MaderaColors.textHeaderColor,
                          ),
                          text: Text(
                            'ID. Projet',
                            style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
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
                            style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                                  color: cTheme.MaderaColors.textHeaderColor,
                                ),
                                text: Text(
                                  'Nom ou Raison Sociale',
                                  style: cTheme.MaderaTextStyles.appBarTitle
                                      .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              onTap: () =>
                                  _formScrollController.position.moveTo(110.0),
                              onChanged: (text) {
                                Provider.of<ProviderProjet>(context)
                                    .clientName = text;
                              },
                              enabled: true,
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
                                  color: cTheme.MaderaColors.textHeaderColor,
                                ),
                                text: Text(
                                  'Adresse client',
                                  style: cTheme.MaderaTextStyles.appBarTitle
                                      .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              onTap: () =>
                                  _formScrollController.position.moveTo(110.0),
                              onChanged: (text) {
                                Provider.of<ProviderProjet>(context)
                                    .clientAdress = text;
                              },
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
                            style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                                  color: cTheme.MaderaColors.textHeaderColor,
                                ),
                                text: Text(
                                  'Téléphone',
                                  style: cTheme.MaderaTextStyles.appBarTitle
                                      .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              onTap: () =>
                                  _formScrollController.position.moveTo(110.0),
                              onChanged: (text) {
                                Provider.of<ProviderProjet>(context).clientTel =
                                    text;
                              },
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
                                  color: cTheme.MaderaColors.textHeaderColor,
                                ),
                                text: Text(
                                  'Adresse mail',
                                  style: cTheme.MaderaTextStyles.appBarTitle
                                      .copyWith(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            TextField(
                              maxLines: 1,
                              onTap: () =>
                                  _formScrollController.position.moveTo(110.0),
                              onChanged: (text) {
                                Provider.of<ProviderProjet>(context)
                                    .clientMail = text;
                              },
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
                      onChanged: (text) {
                        Provider.of<ProviderProjet>(context)
                            .setDescription(text);
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
                        color: cTheme.MaderaColors.textHeaderColor,
                      ),
                      text: Text(
                        'Description Projet',
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
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
                      color: Provider.of<ProviderProjet>(context)
                              .isFilled('QuoteCreation')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: Provider.of<ProviderProjet>(context)
                          .isFilled('QuoteCreation')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: Provider.of<ProviderProjet>(context)
                          .isFilled('QuoteCreation')
                      ? () {
                          log.d('Saving form...');
                          Provider.of<ProviderProjet>(context).logQC();
                          log.d('Done.');
                          log.d('Quote Creation');
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Quote());
                        }
                      : null,
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
                  onPressed: () {},
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
