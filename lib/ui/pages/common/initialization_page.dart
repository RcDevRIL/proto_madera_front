import 'package:flutter/material.dart';

import 'package:proto_madera_front/ui/widgets/custom_LPI.dart';

///
/// Page to initialize application and welcome user
///   Data synchronization is executed directly in 'custom_lpi.dart' (error catch if token = null)
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class InitializationPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _InitializationPageState createState() => _InitializationPageState();
}

class _InitializationPageState extends State<InitializationPage> {
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
  Widget build(BuildContext pageContext) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/img/logo-madera.png'),
                ),
                MyLinearProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
