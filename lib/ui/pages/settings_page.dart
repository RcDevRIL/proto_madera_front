import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show AppBarMadera, CustomDrawer;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page des paramètres de l'application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

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
    //final args = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Stack(
            children: <Widget>[
              Center(
                child: Consumer<MaderaNav>(
                  builder: (_, mN, c) => Text(
                    mN.pageTitle,
                    style: cTheme.TextStyles.appBarTitle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
                child: AppBarMadera(),
              ),
              CustomDrawer(),
            ],
          ),
        ),
      ),
    );
  }

/*   // à la base j'essayais de mettre cette méthode dans la class MaderaNav, mais ça faisait des bugs.
  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);
      Navigator.of(context).pushReplacement(newRoute);
      var maderaNav = Provider.of<MaderaNav>(context);
      maderaNav.updateCurrent(page.runtimeType);
    });
  } */
}
