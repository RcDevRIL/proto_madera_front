import 'package:flutter/material.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';

import 'package:proto_madera_front/ui/pages/widgets/appbar_madera.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom-drawer.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

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
                padding: EdgeInsets.only(left: 72.0),
                child: AppBarMadera(),
              ),
              CustomDrawer(),
            ],
          ),
        ),
      ),
    );
  }
}
