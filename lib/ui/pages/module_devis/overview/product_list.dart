import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show QuoteOverview, ProductCreation;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// List of products saved for current project
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
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
    // Décommente la ligne en dessous
    // final productList = Provider.of<ProviderProjet>(context).productList;
    final productList = ['Produit n°1', 'Produit n°2'];
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Liste des produits', //TODO implémenter getProductsCount dans Provider Projet
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
                    itemCount: productList.length,
                    itemBuilder: (c, i) =>
                        _createProductTile(i, productList[i]),
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
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductCreation());
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
                                Provider.of<MaderaNav>(context)
                                    .redirectToPage(context, ProductCreation());
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
                      color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  tooltip: "Valider produit",
                  onPressed: () {
                    log.d("Quote Overview");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, QuoteOverview());
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
                Provider.of<MaderaNav>(context)
                    .redirectToPage(context, ProductCreation());
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
                //TODO Provider.of<ProviderProjet>(context).deleteProduct(productID);
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
