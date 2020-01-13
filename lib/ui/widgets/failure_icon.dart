import 'package:flutter/material.dart';

/// Custom widget representing a icon that reminds failure
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class FailureIcon extends StatelessWidget {
  const FailureIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: Center(
            child: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 50.0,
        )));
  }
}
