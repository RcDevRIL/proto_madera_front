import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/pages/widgets/appbar_madera.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom-drawer.dart';

import 'package:proto_madera_front/ui/pages/widgets/log_out_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final log = Logger();
  var _maderaNav;

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context).settings.arguments;
    _maderaNav = Provider.of<MaderaNav>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
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
            padding: const EdgeInsets.all(72.0), // 72.0 : largeur drawer
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("PAGE PRINCIPALE"),
                  RaisedButton(
                    onPressed: () {
                      log.d('COUCOU JE SUIS UN LOG');
                    },
                    child: Text("Log me"),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _redirectToPage(context, SettingsPage());
                    },
                    child: Text("Lien vers Settings"),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 72.0),
            child: AppBarMadera(),
          ),
          CustomDrawer(),
        ],
      ),
    );
  }

  // à la base j'essayais de mettre cette méthode dans la class MaderaNav, mais ça faisait des bugs.
  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
      var maderaNav = Provider.of<MaderaNav>(context);
      maderaNav.updateCurrent(page.runtimeType);
    });
  }
}
