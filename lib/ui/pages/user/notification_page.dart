import 'package:flutter/material.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold;

///
/// User Notification page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class NotificationPage extends StatefulWidget {
  static const routeName = '/bell';

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
        child: Text(
          "A venir...",
          style: Theme.of(context).textTheme.display1,
        ),
      ),
    );
  }
}
