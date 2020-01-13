import 'package:flutter/material.dart';

/// Custom widget representing [CircularProgressIndicator]
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class PendingAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
//        ModalBarrier(
//          dismissible: false,
//          color: Colors.black.withOpacity(0.3),
//        ),
      ],
    );
  }
}
