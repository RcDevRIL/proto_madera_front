import 'package:flutter/material.dart';

import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';

///
/// Custom Scaffold to compose with appbar and drawer
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class MaderaScaffold extends StatefulWidget {
  final Widget child;
  final List<Widget> stackAdditions;
  final BuildContext passedContext;

  ///
  /// Constructeur pour faire notre page par défaut.
  ///
  MaderaScaffold({
    Key key,
    @required this.passedContext,
    @required this.child,
    this.stackAdditions = const <Widget>[],
  }) : super(key: key);

  @override
  _MaderaScaffoldState createState() => _MaderaScaffoldState();
}

class _MaderaScaffoldState extends State<MaderaScaffold> {
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
          resizeToAvoidBottomInset:
              false, // Cette option permet de faire en sorte que les éléments de la page ne soient pas 'remontés' si on ouvre le clavier (page auth n'a pas cette option pour le moment)
          backgroundColor: Colors.white,
          body: Stack(
            children: _buildStack(widget.passedContext, widget.stackAdditions),
          ),
        ),
      ),
    );
  }

  _buildStack(BuildContext context, List<Widget> stackAdditions) {
    List<Widget> stack = <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(
          cTheme.Dimens.drawerMinWitdh,
          MediaQuery.of(context).size.height / 12,
          0,
          0,
        ),
        child: InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: widget.child,
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
        child: AppBarMadera(),
      ),
      CustomDrawer(),
    ];
    if (stackAdditions.isNotEmpty) stack.insertAll(1, stackAdditions);
    return stack;
  }
}
