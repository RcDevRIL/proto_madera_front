import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/providers/provider_login.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderProjet, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show QuoteOverview, ProductCreation;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// List of products saved for current project
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
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
                      horizontal: MediaQuery.of(context).size.width / 7.3,
                      vertical: 10.0,
                    ),
                    itemCount: providerProjet.listProduitWithModule.length,
                    itemBuilder: (c, i) =>
                        _createProductTile(i, providerProjet.listProduitWithModule[i].produit.produitNom),
                    separatorBuilder: (c, i) => SizedBox(
                      height: 10.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 7.3,
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
                          log.d("Adding a new product");
                          Provider.of<ProviderProjet>(context)
                              .initProductCreationModel();
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
                              tooltip: "Supprimer produit",
                              onPressed: () {
                                log.d("Adding a new product");
                                //TODO supprimer le produit
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
          padding: EdgeInsets.fromLTRB(
              1200, MediaQuery.of(context).size.height / 6, 0, 0),
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
                  tooltip: "Valider Projet",
                  onPressed: () async {
                    log.d("Create projetWithAllInfos");
                    providerProjet.initProjetWithAllInfos();
                    if(!await Provider.of<ProviderLogin>(context).ping()) {
                      log.d("Appel serveur");
                      await Provider.of<ProviderSynchro>(context).createProjectOnServer(providerProjet.projetWithAllInfos);
                    } else {
                      log.d("Application offline, register in bdd local");
                      providerBdd.createAll(providerProjet.projetWithAllInfos);
                    }
                    //TODO reset infos providerProjet !
                    log.d("Quote Overview");
                    Provider.of<ProviderProjet>(context).validate(true);

                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, QuoteOverview(), null);
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

  Widget _createProductTile(int productID, String product) {
    return MaderaRoundedBox(
      edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
      boxHeight: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('$productID | $product'),
            IconButton(
              icon: Icon(
                Icons.mode_edit,
                color: cTheme.MaderaColors.maderaBlueGreen,
                semanticLabel: 'Bouton d' 'édition',
              ),
              alignment: Alignment.center,
              color: Colors.transparent,
              hoverColor: Colors.white70,
              iconSize: 24.0,
              tooltip: 'Editer produit',
              onPressed: () {
                log.d("Modifying product...");
                Provider.of<ProviderProjet>(context)
                    .loadProductCreationModel(productID);
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
                log.d("Deleting product...");
                Provider.of<ProviderProjet>(context)
                    .deleteProductCreationModel(productID);
              },
            ),
          ],
        ),
      ), // On considère que l'id est l'index dans la liste des produits
      // mais ça changera, on prendra l'id en BDD
    ); // supp cette ligne, et décommente celle en dessous
    // title: Text(productList[i]),;
  }
}
