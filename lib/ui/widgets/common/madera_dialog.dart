import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';

class MaderaDialog extends StatelessWidget {
  final String title;
  final Color titleAndIconColor;
  final IconData icon;
  final List<Widget> actions;
  final Widget body;

  MaderaDialog(
      {Key key,
      @required this.title,
      this.titleAndIconColor = Colors.red,
      this.icon,
      @required this.actions,
      @required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      title: LabelledIcon(
        text: Text(title, style: TextStyle(color: titleAndIconColor)),
        icon: Icon(
          icon,
          color: titleAndIconColor,
        ),
      ),
      content: body,
      actions: actions,
    );
  }
}
