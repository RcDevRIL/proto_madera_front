import 'dart:io';

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
  static final ThemeData base = ThemeData.light();
  static final ThemeData defaultTheme = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    return ThemeData(
      platform: TargetPlatform.android,
      brightness: Brightness.light,
      ////////////////COLORS////////////////////
      accentColorBrightness: Brightness.light,
      primarySwatch: Colors
          .blueGrey, //change par exemple la couleur des bordures lors du focus d'un inputtext
      primaryColorDark: MaderaColors.maderaDarkGreen,
      primaryColor: MaderaColors.maderaGreen,
      primaryColorBrightness: Brightness.light,
      primaryColorLight: MaderaColors.maderaLightGreen,
      accentColor: MaderaColors
          .maderaGreen, //change par exemple la couleur de la barre de chargement au démarrage de l'application
      backgroundColor: Colors.white,
      splashColor: MaderaColors.maderaLightGreen,
      dialogBackgroundColor: Colors.white,
      //////////////////////////////////////////
      ////////////////THEMES////////////////////
      fontFamily: FontNameDefault,
      textTheme: defaultTextTheme,
      primaryTextTheme: defaultTextTheme,
      accentTextTheme: TextTheme.lerp(defaultTextTheme, TextTheme(),
          2), // je sais pas si on va voir la différence
      iconTheme: defaultIconThemeData,
      primaryIconTheme: defaultIconThemeData,
      accentIconTheme:
          IconThemeData.lerp(defaultIconThemeData, IconThemeData(), 2.0),
      appBarTheme: defaultAppBarTheme,
      cardTheme: CardTheme(), //TODO
      dialogTheme: DialogTheme(), //TODO
      buttonTheme: ButtonThemeData(), //TODO
      //////////////////////////////////////////
    );
  }

  ///
  /// Thème de notre AppBar
  ///
  static final AppBarTheme defaultAppBarTheme = AppBarTheme(
    brightness: Brightness.light,
    color: MaderaColors.appBarMainColor,
    elevation: Dimens.appBarElevation,
    textTheme: defaultTextTheme,
    iconTheme: defaultIconThemeData,
    actionsIconTheme: defaultIconThemeData,
  );

  ///
  /// Thème par défaut des icones
  ///
  static final IconThemeData defaultIconThemeData = IconThemeData(
    color: MaderaColors.iconsMainColor,
    size: 32.0,
    opacity: 1.0,
  );

  ///
  /// Thème par défaut des textes
  ///
  static final TextTheme defaultTextTheme = TextTheme(
    title: MaderaTextStyles.appBarTitle,
    body1: MaderaTextStyles.listTileDefaultTextStyle,
    body2: MaderaTextStyles.listTileSelectedTextStyle,
    button: MaderaTextStyles.listTileDefaultTextStyle,
    caption: MaderaTextStyles.listTileDefaultTextStyle,
    display1: MaderaTextStyles.appBarTitle,
    display2: MaderaTextStyles.appBarTitle,
    display3: MaderaTextStyles.appBarTitle,
    display4: MaderaTextStyles.appBarTitle,
    headline: MaderaTextStyles.appBarTitle,
    overline:
        MaderaTextStyles.listTileDefaultTextStyle.copyWith(fontSize: 10.0),
    subhead: MaderaTextStyles.appBarTitle.copyWith(fontSize: 20.0),
    subtitle: MaderaTextStyles.appBarTitle.copyWith(fontSize: 16.0),
  );
}

class MaderaColors {
  const MaderaColors();

  static const Color maderaAccentGreen =
      const Color.fromRGBO(109, 243, 115, 1.0);
  static const Color maderaLightGreen =
      const Color.fromRGBO(178, 250, 180, 0.75);
  static const Color maderaGreen = const Color.fromRGBO(139, 195, 74, 1.0);
  static const Color maderaDarkGreen = const Color.fromRGBO(39, 72, 0, 1.0);
  static const Color maderaBlueGreen = const Color.fromRGBO(0, 150, 136, 0.75);
  static const Color maderaBlueGreen2 =
      const Color.fromRGBO(139, 195, 174, 1.0);
  static const Color maderaLightGrey = const Color.fromRGBO(224, 224, 224, 1.0);
  static const Color maderaGrey = const Color.fromRGBO(117, 117, 117, 1.0);
  static const Color maderaDarkGrey = const Color.fromRGBO(39, 45, 52, 1.0);

  static Color appBarMainColor = selectedColor.withOpacity(0.5);
  static const Color iconsMainColor = maderaDarkGreen;
  static const Color textHeaderColor = maderaDarkGreen;
  static const Color selectedColor = maderaAccentGreen;
  static const Color drawerBackgroundColor = maderaDarkGrey;
  static const Color maderaCardHeader = maderaLightGrey;
  static const Color boxBorder = maderaLightGreen;
  static const Color boxBorderDark = maderaBlueGreen;
  static Color maderaButtonBorder = maderaGrey.withOpacity(0.5);
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
  static const loginFormHeight = 380.0;
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

class MaderaTextStyles {
  const MaderaTextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: MaderaColors.textHeaderColor,
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
