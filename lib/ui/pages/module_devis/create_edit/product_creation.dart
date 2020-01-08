import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_bdd.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AddModule, ProductList;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

///
/// Product creation page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class ProductCreation extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _ProductCreationState createState() => _ProductCreationState();
}

class _ProductCreationState extends State<ProductCreation> {
  final log = Logger();
  String dropdownGammeValue;
  String dropdownModeleValue;
  bool canValidateForm;
  int gammesId;

  TextEditingController _produitNomEditingController;

  //added to prepare for scaling
  @override
  void initState() {
    _produitNomEditingController = TextEditingController();
    gammesId = 0;
    super.initState();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    _produitNomEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<ProviderProjet>(context).produitNom != null) {
      _produitNomEditingController.text =
          Provider.of<ProviderProjet>(context).produitNom;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments;
    var providerProjet = Provider.of<ProviderProjet>(context);
    var providerBdd = Provider.of<ProviderBdd>(context);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Produit n°${Provider.of<ProviderProjet>(context).editProductIndex}', //TODO implémenter getProductNumber dans Provider Projet
              style:
                  cTheme.MaderaTextStyles.appBarTitle.copyWith(fontSize: 32.0),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  MaderaCard(
                    cardWidth: MediaQuery.of(context).size.width / 2,
                    cardHeight: 40.0,
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      enabled: true,
                      controller: _produitNomEditingController,
                      onChanged: (String newValue) {
                        providerProjet.produitNom = newValue;
                      },
                      decoration: InputDecoration(
                        hintText: 'Nom du produit...',
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
                        Icons.text_fields,
                        color: cTheme.MaderaColors.textHeaderColor,
                      ),
                      text: Text(
                        "Nom du produit",
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxHeight: 55,
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    edgeInsetsMargin: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: providerProjet.gamme,
                      hint: Text('Sélectionnez une gamme...'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      items: providerBdd.listGammes
                          .map<DropdownMenuItem<String>>(
                              (GammeData gamme) => DropdownMenuItem<String>(
                                    value: gamme.libelleGammes,
                                    child: Text(gamme.libelleGammes),
                                  ))
                          .toList(),
                      onChanged: (String newValue) {
                        dropdownGammeValue = newValue;
                        dropdownModeleValue = null;
                        providerBdd.listGammes.forEach(
                          (gamme) async => {
                            if (gamme.libelleGammes == newValue)
                              {
                                providerProjet.setModel(dropdownModeleValue),
                                //Enregistre la nouvelle gamme
                                providerProjet.setGamme(newValue),
                                gammesId = gamme.gammeId,
                                //Initialise la liste des modeles avec la gamme
                                await providerBdd
                                    .initListProduitModele(gamme.gammeId),
                                providerProjet.resetListProduitModuleProjet(
                                    providerBdd.listProduitModule),
                              }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    boxHeight: cTheme.Dimens.boxHeight,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: providerProjet.model,
                      hint: Text('Sélectionnez un modèle...'),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      items: providerBdd.listProduitModele != null
                          ? providerBdd.listProduitModele
                              .map<DropdownMenuItem<String>>(
                                (ProduitData produit) =>
                                    DropdownMenuItem<String>(
                                  value: produit.produitNom,
                                  child: Text(produit.produitNom),
                                ),
                              )
                              .toList()
                          : null,
                      onChanged: dropdownGammeValue != null
                          ? (String newValue) {
                              dropdownModeleValue = newValue;
                              providerBdd.listProduitModele.forEach(
                                (produit) async => {
                                  if (produit.produitNom == newValue)
                                    {
                                      //TODO probleme lors de l'init de la valeur modele ! (ex : on revient de l'ajout de module ca marche pas)
                                      providerProjet
                                          .setModel(dropdownModeleValue),
                                      //Charge les produitModules
                                      await providerBdd.initListProduitModule(
                                        produit.produitId,
                                      ),
                                      providerProjet
                                          .initListProduitModuleProjet(
                                        providerBdd.listProduitModule,
                                      ),
                                    }
                                },
                              );
                            }
                          : null,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaCard(
                    cardHeight: MediaQuery.of(context).size.height / 3.2,
                    child: Stack(
                      children: <Widget>[ListView.separated(
                                shrinkWrap: true,
                                itemCount:
                                    providerProjet.listProduitModuleProjet !=
                                            null
                                        ? providerProjet
                                            .listProduitModuleProjet.length
                                        : 0,
                                itemBuilder: (c, i) => Material(
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor:
                                        cTheme.MaderaColors.maderaBlueGreen,
                                    child: ListTile(
                                      title: Text(
                                        providerProjet.listProduitModuleProjet
                                            .elementAt(i)
                                            .produitModuleNom,
                                      ),
                                    ),
                                    onTap: () {
                                      log.d("Modifying module...");
                                      providerProjet.editModuleIndex = i;
                                      Provider.of<MaderaNav>(context)
                                          .redirectToPage(
                                              context, AddModule(), null);
                                    },
                                  ),
                                ),
                                separatorBuilder: (c, i) => Divider(
                                  color: Colors.green,
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaderaButton(
                            onPressed: () {
                              log.d("Adding Module for this quote");
                              Provider.of<MaderaNav>(context)
                                  .redirectToPage(context, AddModule(), null);
                            },
                            child: LabelledIcon(
                              icon: Icon(Icons.add),
                              text: Text("Ajouter Module"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    header: LabelledIcon(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: cTheme.MaderaColors.textHeaderColor,
                      ),
                      text: Text('Liste des Modules'),
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
                      color:  cTheme.MaderaColors.maderaLightGreen,
                      width: 2),
                  color: providerProjet.isFilled('ProductCreation')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  tooltip: "Valider produit",
                  onPressed: providerProjet.isFilled('ProductCreation')
                      ? () {
                          log.d('Saving form...');
                          providerProjet.logQ();
                          providerProjet.productList[providerProjet
                              .editProductIndex] = providerProjet.quoteValues;
                          providerProjet.initProduitWithModule(
                              _produitNomEditingController.text, gammesId);
                          log.d('Done.');
                          log.d('Quote Overview');
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductList(), null);
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
                  tooltip: "Supprimer produit",
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
