import 'package:flutter/material.dart' show Color, FontWeight, TextStyle;

// Default Font Family
const String FontNameDefault = 'Poppins';

class Colors {
  const Colors();

  static const Color appBarMainColor = Color.fromRGBO(109, 243, 115, 0.45);
  static const Color iconsMainColor = Color.fromRGBO(39, 72, 0, 1.0);
  static const Color primaryTextColor = const Color(0xFF000000);
  static const Color secondaryTextColor = const Color(0xFFFFFFFF);

  static const Color appBarTitle = const Color.fromRGBO(39, 72, 0, 1.0);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);

  static const Color selectedColor = const Color.fromRGBO(109, 243, 115, 1.0);
  static const Color drawerBackgroundColor = Color(0xFF272D34);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color white70 = Color.fromRGBO(255, 255, 255, 0.7);

  static const Color containerBackground = Color.fromRGBO(255, 255, 255, 1);
}

class Dimens {
  const Dimens();
  //problème sur certaines valeurs je pense pour le déploiement sur pleins d'écran différent...
  //  à  terme il faudra utiliser directement dans le code des MediaQuery.of(context).size,etc.
  static const drawerMinWitdh = 72.0;
  static const drawerMaxWidth = 220.0;
  static const drawerIconSize = 40.0;
  static const containerHeight = 500.0;
  static const containerWidth = 1000.0;
  static const loginFormWidth = 250.0;
  static const appBarElevation = 50.0;
  static const quoteButtonWidth = 300.0;
  static const quoteButtonHeight = 300.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: Colors.appBarTitle,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w900,
    fontSize: 26.0,
  );

  static const TextStyle listTileDefaultTextStyle = TextStyle(
    color: Colors.white70,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
  );

  static const TextStyle listTileSelectedTextStyle = TextStyle(
    color: Colors.white,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );
}
