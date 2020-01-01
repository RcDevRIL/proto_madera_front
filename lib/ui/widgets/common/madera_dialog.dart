import 'package:flutter/material.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';

class MaderaDialog extends StatefulWidget {
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
  _MaderaDialogState createState() => _MaderaDialogState();
}

class _MaderaDialogState extends State<MaderaDialog> {
  @override
  Widget build(BuildContext context) {
    return _showPopup(context, widget.title, widget.message);
    // Dialog(
    //   elevation: 0.0,
    //   backgroundColor: Colors.transparent,
    //   child: MaderaRoundedBox(
    //     boxHeight: 250,
    //     boxWidth: 400,
    //     edgeInsetsPadding: EdgeInsets.all(8.0),
    //     child: Container(),
    //   ),
    // );
  }

  _showPopup(BuildContext context, String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: LabelledIcon(
              icon: Icon(widget.icon),
              text: Text(title),
            ),
            content: Text(message),
            actions: widget.actions,
          );
        });
  }
}
