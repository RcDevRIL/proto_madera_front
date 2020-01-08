import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderProjet;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/pages.dart' show ProductCreation;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var providerProjet = Provider.of<ProviderProjet>(context);
    var providerBdd = Provider.of<ProviderBdd>(context);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Informations générales',
              style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                fontSize: 32.0,
              ),
            ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          child: Text(providerProjet.dateNow),
                        ),
                      ),
                      MaderaCard(
                        cardWidth:
                            MediaQuery.of(context).size.width / 2.4 - 168.0,
                        cardHeight: cTheme.Dimens.cardHeight,
                        child: TextField(
                          onChanged: (String newValue) {
                            providerProjet.setProjetNom(newValue);
                          },
                          decoration: InputDecoration(
                            hintText: providerProjet.projetNom == null ||
                                    providerProjet.projetNom.isEmpty
                                ? null
                                : providerProjet.projetNom,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
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
                            'Nom du Projet',
                            style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                      ),
                      MaderaCard(
                        cardWidth: 250.0,
                        cardHeight: cTheme.Dimens.cardHeight,
                        child: Center(
                          child: providerProjet.client != null
                              ? Text(
                                  '${providerProjet.dateNow.replaceAll('/', '')}_${providerProjet.client.id}')
                              : Text(
                                  '${providerProjet.dateNow.replaceAll('/', '')}'),
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
                            providerProjet.client != null
                                ? Container(
                                    height: 50.0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        providerProjet.client.nom +
                                            ' ' +
                                            providerProjet.client.prenom,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 50.0,
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
                            //TODO trouver une autre implémentation pour éviter le futurebuilder?
                            providerProjet.client != null
                                ? FutureBuilder(
                                    future: providerBdd.buildClientAdresse(
                                        providerProjet.client.id),
                                    // initialData: 'NO ADRESS LOADED',
                                    builder: (c, s) {
                                      if (s.hasData) {
                                        return Container(
                                          height: 50.0,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(s.data),
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                  )
                                : Container(
                                    height: 50.0,
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
                            providerProjet.client != null
                                ? Container(
                                    height: 50.0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        providerProjet.client.numTel,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 50.0,
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
                            providerProjet.client != null
                                ? Container(
                                    height: 50.0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        providerProjet.client.mail,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 50.0,
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
                        hintText: providerProjet.description == null ||
                                providerProjet.description.isEmpty
                            ? 'Rentrez la description du projet ici'
                            : providerProjet.description,
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
                          providerProjet.initProjet();
                          providerProjet.initProductCreationModel();
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
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: providerProjet.client != null
                              ? Text(providerProjet.client.nom +
                                  ' ' +
                                  providerProjet.client.prenom)
                              : Text('Sélectionnez un client...'),
                          icon: Icon(Icons.arrow_drop_down,
                              color: cTheme.MaderaColors.maderaLightGreen),
                          iconSize: 35,
                          elevation: 16,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .apply(fontSizeDelta: -8),
                          underline: Container(
                            height: 2,
                            width: 100.0,
                            color: Colors.transparent,
                          ),
                          onChanged: (String newValue) {
                            providerBdd.listClient.forEach((client) => {
                                  if (client.nom + ' ' + client.prenom ==
                                      newValue)
                                    {
                                      providerProjet
                                          .initClientWithClient(client),
                                    }
                                });
                            Navigator.of(context).pop();
                            didChangeDependencies();
                          },
                          items: providerBdd.listClient
                              .map<DropdownMenuItem<String>>(
                                  (ClientData client) =>
                                      DropdownMenuItem<String>(
                                        value: client.nom + ' ' + client.prenom,
                                        child: Text(
                                            client.nom + ' ' + client.prenom),
                                      ))
                              .toList(),
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
