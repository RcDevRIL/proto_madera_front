///
/// Ici se trouvent plusieurs classes constituant notre thème
/// Certaines valeurs sont importés de Mockflow afin que l'interface corresponde à la maquette
/// D'autres valeurs ont été créées lors du développement de ce prototype pour répondre au besoin de consistance d'UI
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
import 'package:flutter/material.dart';

// Default Font Family
const String FontNameDefault = 'Poppins';

class CustomTheme {
  static final ThemeData defaultTheme = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      primaryColor: Colors.green,
      iconTheme: IconThemeData(
        color: MaderaColors.iconsMainColor,
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: MaderaColors.iconsMainColor,
        ),
        color: MaderaColors.appBarMainColor,
      ),
    );
  }
}

class MaderaColors {
  const MaderaColors();

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

  static const Color containerBackgroundLinearStart =
      Color.fromRGBO(178, 250, 180, 0.75);
  static const Color containerBackgroundLinearEnd =
      Color.fromRGBO(0, 150, 136, 0.75);

  static const Color boxBorder = Color.fromRGBO(178, 250, 180, 1);
}

class Dimens {
  const Dimens();
  //problème sur certaines valeurs je pense pour le déploiement sur pleins d'écran différent...
  //  à  terme il faudra utiliser directement dans le code des MediaQuery.of(context).size,etc.
  static const drawerMinWitdh = 72.0;
  static const drawerMaxWidth = 220.0;
  static const drawerIconSize = 40.0;
  static const containerHeight = 580.0;
  static const containerWidth = 1000.0;
  static const loginFormWidth = 250.0;
  static const appBarElevation = 50.0;
  static const quoteButtonWidth = 300.0;
  static const quoteButtonHeight = 300.0;
  static const buttonPaddingRight = 10.0;
  static const buttonPaddingBottom = 0.0;
  static const cardSizeSmall = 250.0;
  static const cardSizeXSmall = 155.0;
  static const cardSizeMedium = 821.0;
  static const cardSizeLarge = 980.0;
  static const cardHeight = 45.0;
  static const cardHeightLarge = 450.0;
  static const boxWidth = 250.0;
  static const boxWidthMedium = 350.0;
  static const boxHeight = 60.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: MaderaColors.appBarTitle,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w900,
    fontSize: 26.0,
  );

  static const TextStyle listTileDefaultTextStyle = TextStyle(
    color: MaderaColors.white70,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
  );

  static const TextStyle listTileSelectedTextStyle = TextStyle(
    color: MaderaColors.white,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );
}
