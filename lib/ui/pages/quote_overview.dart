import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/providers.dart' show MaderaNav;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show AppBarMadera, CustomDrawer;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page de "Suivi des devis enregistrés"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class QuoteOverview extends StatefulWidget {
  static const routeName = '/quoteOverview';

  @override
  _QuoteOverviewState createState() => _QuoteOverviewState();
}

class _QuoteOverviewState extends State<QuoteOverview> {
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
}
