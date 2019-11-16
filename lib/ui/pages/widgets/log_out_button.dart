import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = Logger();
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        //TODO Emettre un évènement de déconnexion
        log.d("LOGOUT EVENT");
      },
    );
  }
}
