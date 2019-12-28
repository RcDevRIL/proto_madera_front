import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderSynchro;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show AppBarMadera, CustomDrawer;
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page d'accueil de l'application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class HomePage extends StatelessWidget {
  static const routeName = '/home';
  final log = Logger();

  ///
  /// Prevents the use of the 'back' button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: _buildHomePage(context),
        ),
      ),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
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
                        /**
                         * Bouton custom test
                         */
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: <Widget>[
                        //     RaisedButton(
                        //       onPressed: () {},
                        //       child: Icon(Icons.note_add, size: 50.0,),
                        //     ),

                        //     Text("Création de devis"),
                        //   ],
                        // ),
                        // icon: Icon(Icons.note_add),
                        // label: Text('Création de devis'),
                        // ),

                        Container(
                          height: 150.0,
                          width: 150.0,
                          child: RaisedButton(
                            onPressed: () {
                              mN.redirectToPage(context, QuoteOverview());
                            },
                            child: Text('Suivi de devis'),
                          ),
                        ),
                        /**
                         * Bouton custom test 2
                         */
                        // Column(
                        //   children: <Widget>[
                        //     Container(
                        //       padding: EdgeInsets.all(0.0),
                        //       margin: EdgeInsets.all(0.0),
                        //       color: Colors.blueGrey,
                        //       constraints: BoxConstraints.expand(
                        //         height: 50.0,
                        //         width: 50.0,
                        //       ),
                        //       child: RaisedButton(
                        //         onPressed: () {},
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(15.0),
                        //           side: BorderSide(
                        //             color: Colors.white,
                        //             style: BorderStyle.solid,
                        //             width: 2.0,
                        //           ),
                        //         ),
                        //         child: Center(
                        //           child: Icon(Icons.ac_unit),
                        //         ),
                        //       ),
                        //     ),
                        //     Text(
                        //       "Création de devis",
                        //       style: cTheme.TextStyles.appBarTitle,
                        //     ),
                        //   ],
                        // ),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          child: RaisedButton(
                            onPressed: () {
                              mN.redirectToPage(context, QuoteCreation());
                            },
                            child: Text('Création de devis'),
                          ),
                        ),
                        Container(
                          height: 150.0,
                          width: 150.0,
                          child: RaisedButton(
                            onPressed: () {
                              mN.redirectToPage(context, SettingsPage());
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
                            child:
                                Text('Log libélllés états possibles des devis'),
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
                              mN.redirectToPage(context, NotificationPage());
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
          ),
          Padding(
            padding: EdgeInsets.only(
              left: cTheme.Dimens.drawerMinWitdh,
            ),
            child: AppBarMadera(),
          ),
          CustomDrawer(),
        ],
      ),
    );
  }
}
