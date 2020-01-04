import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

/// Custom widget representing an [AlertDialog].
class MaderaDialog extends StatelessWidget {
  /// Creates a custom alert dialog.
  ///
  /// The [title], [body] and [actions] arguments must not be null.
  /// Additionally, the [icon] and [titleAndIconColor] arguments can be instanciated
  /// to better fit our expectations.

  /// The title to be displayed on the header.
  final String title;

  /// The color to be used on the [title] and its [icon].
  final Color titleAndIconColor;

  /// The icon to use on the header.
  final IconData icon;

  /// The list of Widget displayed on the footer, usually a list of [MaderaButton] that perform some actions
  final List<Widget> actions;

  /// The body of this widget.
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: cTheme.MaderaColors.boxBorder,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      title: LabelledIcon(
        text: Text(title, style: TextStyle(color: titleAndIconColor)),
        icon: Icon(
          icon,
          color: titleAndIconColor,
        ),
      ),
      content: body.runtimeType == Text
          ? Container(
              height: 50.0,
              child: body,
            )
          : Container(
              height: 150.0,
              child: body,
            ),
      actions: actions,
      semanticLabel: title,
    );
  }
}
