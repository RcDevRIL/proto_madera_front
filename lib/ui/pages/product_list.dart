import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show QuoteOverview, Quote;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page de "Edition de devis"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
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
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                'Liste des produits', //TODO implémenter getProductsCount dans Provider Projet
                style: cTheme.TextStyles.appBarTitle.copyWith(fontSize: 32.0),
              ),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: _createProductTile(
                          1) // supp cette ligne, décommenter celle du dessous
                      // child: _createProductTile(productList[i])

                      ),
                  SizedBox(height: 20.0),
                  Container(
                    child: MaderaRoundedBox(
                      color: Colors.grey,
                      boxHeight: 50,
                      boxWidth: MediaQuery.of(context).size.width / 2,
                      edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: InkWell(
                        onTap: () {
                          log.d("Adding a new product");
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Quote());
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: cTheme
                                        .Colors.containerBackgroundLinearStart,
                                    width: 2),
                                color: Colors.grey),
                            child: IconButton(
                              tooltip: "Supprimer produit",
                              onPressed: () {
                                log.d("Adding a new product");
                                Provider.of<MaderaNav>(context)
                                    .redirectToPage(context, Quote());
                              },
                              icon: Icon(
                                Icons.add,
                                color: cTheme
                                    .Colors.containerBackgroundLinearStart,
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
                      color: cTheme.Colors.containerBackgroundLinearStart,
                      width: 2),
                  color: cTheme.Colors.containerBackgroundLinearEnd,
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
                  tooltip: "Supprimer produit",
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

  Widget _createProductTile(int productID) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 1, // supp cette ligne, et décommente celle en dessous
      // itemCount: productList.length,
      itemBuilder: (c, i) => InkWell(
        onTap: () {
          log.d("Modifying product...");
          Provider.of<MaderaNav>(context).redirectToPage(context, Quote());
        },
        highlightColor: Colors.transparent,
        splashColor: cTheme.Colors.containerBackgroundLinearEnd,
        child: MaderaRoundedBox(
          boxHeight: cTheme.Dimens.boxHeight,
          edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
          boxWidth: MediaQuery.of(context).size.width,
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text('$productID | Nom: nom produit')),
        ),
      ), // supp cette ligne, et décommente celle en dessous
      // title: Text(productList[i]),
      separatorBuilder: (c, i) => Divider(
        color: Colors.green,
      ),
    );
  }
}
