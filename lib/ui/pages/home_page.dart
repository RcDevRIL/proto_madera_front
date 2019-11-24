import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Consumer<MaderaNav>(
                    builder: (_, mN, c) => Text(
                      mN.pageTitle,
                      style: cTheme.TextStyles.appBarTitle,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            MaderaNav().redirectToPage(context, Quote());
                          },
                          child: Text('Création de devis'),
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            MaderaNav().redirectToPage(context, QuoteOverview());
                          },
                          child: Text('Suivi de devis'),
                        ),
                      ),
                      Container(
                        height: 150.0,
                        width: 150.0,
                        child: RaisedButton(
                          onPressed: () {
                            MaderaNav().redirectToPage(context, SettingsPage());
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
                            MaderaNav().redirectToPage(context, NotificationPage());
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

  // à la base j'essayais de mettre cette méthode dans la class MaderaNav, mais ça faisait des bugs.
  // void _redirectToPage(BuildContext context, Widget page) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     MaterialPageRoute newRoute =
  //         MaterialPageRoute(builder: (BuildContext context) => page);
  //     Navigator.of(context).pushReplacement(newRoute);
  //     var maderaNav = Provider.of<MaderaNav>(context);
  //     maderaNav.updateCurrent(page.runtimeType);
  //   });
  // }
}
