import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';

class MaderaDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<MaderaButton> actions;
  final String message;

  MaderaDialog(
      {Key key,
      @required this.title,
      this.icon,
      @required this.actions,
      @required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$title',
        style: TextStyle(color: Colors.red),
      ),
      content: Text('$message'),
      actions: <Widget>[
        MaderaButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
