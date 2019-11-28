import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class Quote extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
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
              Padding(
                padding: EdgeInsets.fromLTRB(cTheme.Dimens.drawerMinWitdh, MediaQuery.of(context).size.height / 12, 0, 0),
                child: Center(
                  /** Centre de la page */
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: cTheme.Dimens.containerWidth,
                    height: cTheme.Dimens.containerHeight,
                    color: cTheme.Colors.containerBackground,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RaisedButton(
                        onPressed: () {},
                        child: LabelledIcon(
                          icon: Icon(Icons.check),
                          text: Text("Valider"),
                        ),
                        // icon: Icon(Icons.check),
                        // label: Text("Valider"),
                        // backgroundColor: Colors.green,
                      ),
                    ),
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

/*   // Ã  la base j'essayais de mettre cette mÃ©thode dans la class MaderaNav, mais Ã§a faisait des bugs.
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
