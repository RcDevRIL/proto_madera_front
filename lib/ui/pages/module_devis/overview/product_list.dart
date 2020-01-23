import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_login.dart';
import 'package:proto_madera_front/data/providers/provider_size.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderProjet, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show HomePage, ProductCreation, QuoteOverview;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// List of products saved for current project
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class ProductList extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final log = Logger();
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
    var providerProjet = Provider.of<ProviderProjet>(context);
    var providerBdd = Provider.of<ProviderBdd>(context);
    var providerSize = Provider.of<ProviderSize>(context);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Liste des produits',
              style:
                  cTheme.MaderaTextStyles.appBarTitle.copyWith(fontSize: 32.0),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: providerSize.productListBlankWidth,
                      vertical: 10.0,
                    ),
                    itemCount: providerProjet.listProduitProjet.length,
                    itemBuilder: (c, i) => _createProductTile(
                        i, providerProjet.listProduitProjet[i].produit),
                    separatorBuilder: (c, i) => SizedBox(
                      height: 10.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: providerSize.productListBlankWidth,
                    ),
                    child: MaderaRoundedBox(
                      color: Colors.grey,
                      edgeInsetsPadding: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 0.0,
                      ),
                      boxHeight: 50,
                      child: InkWell(
                        onTap: () {
                          log.d('Adding a new product');
                          providerProjet.initProductCreationModel();
                          providerProjet.editProductIndex = providerProjet
                              .listProduitProjet.length; //on veut index max +1
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductCreation(), null);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: cTheme.MaderaColors.maderaLightGreen,
                                    width: 2),
                                color: Colors.grey),
                            child: IconButton(
                              tooltip: 'Ajouter un produit',
                              onPressed: () {
                                log.d('Adding a new product');
                                providerProjet.initProductCreationModel();
                                providerProjet.editProductIndex = providerProjet
                                    .listProduitProjet
                                    .length; //on veut index max +1
                                Provider.of<MaderaNav>(context).redirectToPage(
                                    context, ProductCreation(), null);
                              },
                              icon: Icon(
                                Icons.add,
                                color: cTheme.MaderaColors.maderaLightGreen,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      stackAdditions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(providerSize.floatingButtonWidth,
              providerSize.mediaHeight / 6, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cTheme.MaderaColors.maderaLightGreen,
                    width: 2,
                  ),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  tooltip: 'Valider Projet',
                  onPressed: () async {
                    log.d('Create projetWithAllInfos');
                    providerProjet.initProjetWithAllInfos();
                    if (await Provider.of<ProviderLogin>(context).ping()) {
                      log.d('Appel serveur réussi.');
                      log.d('Synchronisation du projet avec le serveur...');
                      await Provider.of<ProviderSynchro>(context)
                          .createProjectOnServer(
                              providerProjet.projetWithAllInfos);
                      if (await Provider.of<ProviderSynchro>(context)
                          .synchroData()) {
                        log.i('New project loaded from backend server');
                        providerProjet.validate(true);
                      } else
                        log.e('Error when trying to synchro user data');
                    } else {
                      log.d('Application offline, register in bdd local');
                      providerBdd.createAll(providerProjet.projetWithAllInfos);
                      providerProjet.validate(true);
                    }
                    Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
                        context,
                        Icons.check_circle,
                        'Projet Sauvegardé',
                        'Le projet a été sauvegardé',
                        QuoteOverview());
                  },
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
                    color: cTheme.MaderaColors.maderaLightGreen,
                    width: 2,
                  ),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  tooltip: 'Abandonner le projet en cours',
                  onPressed: () {
                    Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
                        context,
                        Icons.warning,
                        'Abandon du projet',
                        'Les données en cours de création/modification vont être perdues.',
                        HomePage());
                    providerProjet.validate(false);
                  },
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

  Widget _createProductTile(int productIndex, ProduitData product) {
    return MaderaRoundedBox(
      edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      boxHeight: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
                '${productIndex + 1} | ID:${product.produitId} - ${product.produitNom}'),
            IconButton(
              icon: Icon(
                Icons.mode_edit,
                color: cTheme.MaderaColors.maderaBlueGreen,
                semanticLabel: 'Bouton d\'édition',
              ),
              alignment: Alignment.center,
              color: Colors.transparent,
              hoverColor: Colors.white70,
              iconSize: 24.0,
              tooltip: 'Editer produit',
              onPressed: () {
                log.d('Modifying product...');
                Provider.of<ProviderProjet>(context)
                    .loadProductCreationModel(productIndex);
                // Je set la gamme ici car besoin de récupérer tout le GammeData
                Provider.of<ProviderProjet>(context).gamme =
                    Provider.of<ProviderBdd>(context).listGammes.firstWhere(
                        (gammeData) =>
                            gammeData.gammeId ==
                            Provider.of<ProviderProjet>(context)
                                .listProduitProjet[productIndex]
                                .produit
                                .gammesId);
                Provider.of<MaderaNav>(context)
                    .redirectToPage(context, ProductCreation(), null);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: cTheme.MaderaColors.maderaBlueGreen,
                semanticLabel: 'Bouton de supression',
              ),
              alignment: Alignment.center,
              color: Colors.transparent,
              hoverColor: Colors.white70,
              iconSize: 24.0,
              tooltip: 'Supprimer produit',
              onPressed: () {
                log.d('Deleting product...');
                Provider.of<ProviderProjet>(context)
                    .deleteProductCreationModel(productIndex);
              },
            ),
          ],
        ),
      ),
    );
  }
}
