import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart' show ProductCreation;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Entry point for the quote creation module of our prototype
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
  TextEditingController _clientMailTextEditingController;
  TextEditingController _clientTelTextEditingController;
  TextEditingController _clientAdressTextEditingController;
  TextEditingController _clientNameTextEditingController;

  final log = Logger();

  @override
  void initState() {
    super.initState();
    _formScrollController = ScrollController();
    _clientMailTextEditingController = TextEditingController();
    _clientTelTextEditingController = TextEditingController();
    _clientAdressTextEditingController = TextEditingController();
    _clientNameTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _formScrollController?.dispose();
    _clientMailTextEditingController?.dispose();
    _clientTelTextEditingController?.dispose();
    _clientAdressTextEditingController?.dispose();
    _clientNameTextEditingController?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    /* J'ai du rendre inéditables les fields pour le client car comportement bizarre remplissage que par le dialogue
    */
    _clientNameTextEditingController.text =
        Provider.of<ProviderProjet>(context).clientName;
    _clientAdressTextEditingController.text =
        Provider.of<ProviderProjet>(context).clientAdress;
    _clientTelTextEditingController.text =
        Provider.of<ProviderProjet>(context).clientTel;
    _clientMailTextEditingController.text =
        Provider.of<ProviderProjet>(context).clientMail;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var providerProjet = Provider.of<ProviderProjet>(context);
    dateCreationProjet = providerProjet.dateCreation;
    refProjet = providerProjet.refProjet;
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
                          padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
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
                                providerProjet.clientName =
                                    _clientNameTextEditingController.text;
                              },
                              controller: _clientNameTextEditingController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
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
                                providerProjet.clientAdress =
                                    _clientAdressTextEditingController.text;
                              },
                              controller: _clientAdressTextEditingController,
                              keyboardType: TextInputType.text,
                              enabled: false,
                              decoration: InputDecoration(
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
                          padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
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
                                providerProjet.clientTel =
                                    _clientTelTextEditingController.text;
                              },
                              controller: _clientTelTextEditingController,
                              keyboardType: TextInputType.phone,
                              enabled: false,
                              decoration: InputDecoration(
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
                                providerProjet.clientMail =
                                    _clientMailTextEditingController.text;
                              },
                              controller: _clientMailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              enabled: false,
                              decoration: InputDecoration(
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
                        providerProjet.setDescription(text);
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
                      color: providerProjet.isFilled('QuoteCreation')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('QuoteCreation')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: providerProjet.isFilled('QuoteCreation')
                      ? () {
                          log.d('Saving form...');
                          providerProjet.logQC();
                          log.d('Done.');
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductCreation(), null);
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
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                    color: cTheme.MaderaColors.maderaBlueGreen),
                child: IconButton(
                  onPressed: () {
                    Provider.of<MaderaNav>(context).showPopup(
                      context,
                      Icons.person_add,
                      'Sélection d\'un client',
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          10.0,
                          0.0,
                          10.0,
                          0.0,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: (providerProjet.clientName != null &&
                                        providerProjet.clientName.isNotEmpty)
                                    ? Text(providerProjet.clientName)
                                    : Text('Sélectionnez un client...'),
                                icon: Icon(Icons.arrow_drop_down,
                                    color:
                                        cTheme.MaderaColors.maderaLightGreen),
                                iconSize: 35,
                                elevation: 16,
                                style: Theme.of(context)
                                    .textTheme
                                    .title
                                    .apply(fontSizeDelta: -4),
                                underline: Container(
                                  height: 2,
                                  width: 100.0,
                                  color: Colors.transparent,
                                ),
                                onChanged: (String newValue) {
                                  switch (newValue) {
                                    case 'Client 1':
                                      //TODO récupérer les infos clients en bdd
                                      providerProjet.client = {
                                        'id': '1',
                                        'name': newValue,
                                        'adresse': 'Dijon',
                                        'mail': 'test@test.com',
                                        'tel': '111111',
                                      };
                                      break;
                                    case 'Client 2':
                                      //TODO récupérer les infos clients en bdd
                                      providerProjet.client = {
                                        'id': '2',
                                        'name': newValue,
                                        'adresse': 'Quetigny',
                                        'mail': 'testnumero2@test.com',
                                        'tel': '222222',
                                      };
                                      break;
                                    default:
                                      {}
                                      break;
                                  }
                                  providerProjet.clientName = newValue;
                                  Navigator.of(context).pop();
                                },
                                items: <String>[
                                  'Client 1',
                                  'Client 2',
                                  'Client 3',
                                ]
                                    .map<DropdownMenuItem<String>>(
                                        (String value) =>
                                            DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            ))
                                    .toList(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) =>
                                              providerProjet.clientName = value,
                                          controller: TextEditingController(
                                              text: providerProjet.clientName),
                                          decoration: InputDecoration(
                                            hintText: 'Ex: DUPONT Nicolas',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) => providerProjet
                                              .clientAdress = value,
                                          controller: TextEditingController(
                                              text:
                                                  providerProjet.clientAdress),
                                          decoration: InputDecoration(
                                            hintText: 'Rue complète, CP, ville',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) =>
                                              providerProjet.clientTel = value,
                                          controller: TextEditingController(
                                              text: providerProjet.clientTel),
                                          decoration: InputDecoration(
                                            hintText: 'Téléphone...',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: TextField(
                                          onChanged: (value) =>
                                              providerProjet.clientMail = value,
                                          controller: TextEditingController(
                                              text: providerProjet.clientMail),
                                          decoration: InputDecoration(
                                            hintText: 'Adresse mail...',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      [
                        MaderaButton(
                          key: Key('ok-button'),
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                  icon: Icon(
                    Icons.person_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
