import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page des paramètres de l'application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Consumer<MaderaNav>(
          builder: (_, mN, c) => Text(
            mN.pageTitle,
            style: cTheme.MaderaTextStyles.appBarTitle,
          ),
        ),
      ),
    );
  }
}