import 'package:flutter/material.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold;

///
/// "Page du profil utilisateur"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class UserProfilePage extends StatefulWidget {
  static const routeName = '/bell';

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _userName;
  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
    _userName = 'TEST NAME';
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
      child: Text('$_userName'),
    );
  }
}
