import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold;
import 'package:proto_madera_front/data/database/madera_database.dart';

///
/// Home page of our application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
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
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        mN.redirectToPage(context, QuoteOverview(), null);
                      },
                      child: Text('Suivi de devis'),
                    ),
                  ),
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        Provider.of<ProviderProjet>(context).initAndHold();
                        mN.redirectToPage(context, QuoteCreation(), null);
                      },
                      child: Text('Création de devis'),
                    ),
                  ),
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        mN.redirectToPage(context, SettingsPage(), null);
                      },
                      child: Text('Paramètres'),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () async {
                        List<DevisEtatData> names =
                            await Provider.of<ProviderSynchro>(context)
                                .devisEtatDao
                                .getDevisEtatData();
                        for (DevisEtatData deD in names) {
                          log.d(deD.devisEtatLibelle);
                        }
                      },
                      child: Text('Log libélllés états possibles des devis'),
                    ),
                  ),
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        log.d('COUCOU JE SUIS UN LOG');
                      },
                      child: Text('Log me'),
                    ),
                  ),
                  Container(
                    height: 150.0,
                    width: 150.0,
                    child: RaisedButton(
                      onPressed: () {
                        mN.redirectToPage(context, NotificationPage(), null);
                      },
                      child: Text('Lien vers Notifications'),
                    ),
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
