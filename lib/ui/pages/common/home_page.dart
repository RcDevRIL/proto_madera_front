import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show LabelledIcon, MaderaScaffold;

///
/// Home page of our application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final log = Logger();

  @override
  Widget build(BuildContext context) {
    return MaderaScaffold(
      passedContext: context,
      child: _buildHomePage(context),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Consumer<MaderaNav>(
          builder: (context, mN, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      LabelledIcon(
                        icon: Icon(Icons.search),
                        text: Text('Suivi de devis'),
                      ),
                      InkWell(
                        onTap: () {
                          mN.redirectToPage(context, QuoteOverview(), null);
                        },
                        child: Container(
                          height: 250.0,
                          width: 250.0,
                          child: Image(
                            image: AssetImage('assets/img/suiviDevis.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      LabelledIcon(
                        icon: Icon(Icons.assignment),
                        text: Text('Création de devis'),
                      ),
                      InkWell(
                        onTap: () {
                          Provider.of<ProviderProjet>(context).initAndHold();
                          mN.redirectToPage(context, QuoteCreation(), null);
                        },
                        child: Container(
                          height: 250.0,
                          width: 250.0,
                          child: Image(
                            image: AssetImage('assets/img/creationDevis.jpg'),
                            fit: BoxFit.cover,
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
    );
  }
}
