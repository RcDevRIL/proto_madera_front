import 'package:flutter/material.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';

import 'package:proto_madera_front/ui/pages/widgets/log_out_button.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class AppBarMadera extends StatefulWidget {
  @override
  _AppBarMaderaState createState() => _AppBarMaderaState();
}

class _AppBarMaderaState extends State<AppBarMadera> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          /* BoxConstraints(
        maxHeight: MediaQuery.of(context).devicePixelRatio * 28,
        minHeight: MediaQuery.of(context).devicePixelRatio * 28,
        maxWidth: MediaQuery.of(context).size.width,
        minWidth: MediaQuery.of(context).size.width,
      ), */
          BoxConstraints.tightFor(
        height: MediaQuery.of(context).devicePixelRatio * 28,
        width: MediaQuery.of(context).size.width,
      ),
      child: AppBar(
        primary: true,
        elevation: 50.0,
        backgroundColor: Color.fromRGBO(109, 243, 115, 0.33),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(39, 72, 0, 1.0),
        ),
        // leading: Container(),
        title: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Consumer<MaderaNav>(
                builder: (_, mN, child) => Text(
                  mN.pageTitle,
                  style: cTheme.TextStyles.appBarTitle,
                ),
              ),
              Image(
                image: AssetImage("assets/img/logo-madera.png"),
              ),
            ],
          ),
        ),
        centerTitle: true,
        //actions: <Widget>[],
      ),
    );
  }
}
