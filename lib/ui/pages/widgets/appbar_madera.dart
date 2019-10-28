import 'package:flutter/material.dart';

class AppBarMadera extends AppBar {
  AppBarMadera({Key key, Widget title})
  // C'est ici que je galère, j'arrive pas à dire qu'il peut contenir d'autres Widgets,
  // mais que le premier sera tjr l'icône quoi qu'il arrive
    : super(key: key, title: title, actions:<Widget>[
        new IconButton(
          icon: new ImageIcon(
            AssetImage("assets/img/logo-madera.png"),
            color: null,
          ),
          onPressed: null,
          iconSize: 150,
          color: null,
          alignment: Alignment.centerLeft,
        )
        
    ]);
}