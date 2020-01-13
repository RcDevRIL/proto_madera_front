///
/// Ici se trouvent plusieurs classes constituant notre thème. Cela nous permettra de proposer un thème dynamique.
/// Certaines valeurs sont importés de [Mockflow](https://mockflow.com/) afin que l'interface corresponde à la maquette
/// D'autres valeurs ont été créées lors du développement de ce prototype pour répondre au besoin de consistance d'UI
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
import 'package:flutter/material.dart';

// Default Font Family
const String FontNameDefault = 'Poppins';

///
/// Classe représentant notre thème personalisé.
/// C'est ici que nous construisons le [ThemeData] associé.
///
/// A venir: thème Dark
///
class MaderaTheme {
  static final ThemeData base = ThemeData.light();
  static final ThemeData maderaLightTheme = _buildLightTheme();

  ///
  ///Cette méthode construit le [ThemeData] lorsque l'utilisateur n'est pas en mode Dark.
  /// --> [Brigthness] =  Brigthness.light
  static ThemeData _buildLightTheme() {
    return ThemeData(
      platform: TargetPlatform.android,
      brightness: Brightness.light,
      ////////////////COLORS////////////////////
      primarySwatch: Colors
          .blueGrey, //change par exemple le curseur de sélection d'un inputtext
      primaryColorBrightness: Brightness.light,
      primaryColor: MaderaColors.maderaGreen,
      primaryColorLight: MaderaColors.maderaLightGreen,
      primaryColorDark: MaderaColors.maderaDarkGreen,
      accentColorBrightness: Brightness.light,
      accentColor: MaderaColors
          .maderaAccentGreen, //change par exemple la couleur de la barre de chargement au démarrage de l'application
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
      cardTheme: CardTheme(),
      dialogTheme: DialogTheme(),
      buttonTheme: maderaButtonTheme,
      //////////////////////////////////////////
    );
  }

  ///
  /// [ButtonThemeData] par défaut de notre application
  ///
  /// Est appliqué sur tout les éléments [MaterialButton], [RaisedButton], [FlatButton], etc.
  static final ButtonThemeData maderaButtonTheme = ButtonThemeData(
    // textTheme: ButtonTextTheme.primary,
    disabledColor:
        MaderaColors.maderaGrey, //n'a pas d'effet si le textTheme est défini
    splashColor: MaderaColors.maderaLightGreen,
    height: 25,
    minWidth: 50,
    padding: const EdgeInsets.all(8.0),
    buttonColor: MaderaColors.maderaGreen,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(
        color: MaderaColors.maderaButtonBorder,
        width: 2.0,
      ),
    ),
  );

  ///
  /// [AppBarTheme] par défaut de notre application
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
  /// [IconThemeData] par défaut de notre application
  ///
  static final IconThemeData defaultIconThemeData = IconThemeData(
    color: MaderaColors.iconsMainColor,
    size: 32.0,
    opacity: 1.0,
  );

  ///
  /// [TextTheme] par défaut de notre application
  /// Il permet de définir des styles pour tous les éléments de l'application.
  /// Il est également possible des les récupérer et les transformer au runtime avec la commande:
  /// Theme.of(context).textTheme.[nomDuParamètre].apply()/.copyWith()
  ///
  static final TextTheme defaultTextTheme = TextTheme(
    title: MaderaTextStyles.appBarTitle,
    body1: MaderaTextStyles.defaultTextStyle,
    body2: MaderaTextStyles.listTileSelectedTextStyle,
    button: MaderaTextStyles.defaultTextStyle,
    caption: MaderaTextStyles.defaultTextStyle,
    display1: MaderaTextStyles.appBarTitle,
    display2: MaderaTextStyles.appBarTitle,
    display3: MaderaTextStyles.appBarTitle,
    display4: MaderaTextStyles.appBarTitle,
    headline: MaderaTextStyles.appBarTitle,
    overline: MaderaTextStyles.defaultTextStyle.copyWith(
        fontSize: 14.0), //change le style des valeurs rentrées au clavier
    subhead: MaderaTextStyles
        .defaultTextStyle, //change le style de tous les textes d'un d'inputtext
    subtitle: MaderaTextStyles.appBarTitle.copyWith(fontSize: 42.0),
  );
}

///
///Classe permettant de stocker nos couleurs d'application.
///Il permet aussi de donner des noms plus parlant lorsqu'on veut définir la couleur d'un élément en particulier
class MaderaColors {
  const MaderaColors();

  ////////////////MOCKFLOW VALUES///////////////
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
  //////////////////////////////////////////////

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

///
///Cette classe permet de stocker des dimensions.
class Dimens {
  const Dimens();
  static const drawerMinWitdh = 72.0;
  static const drawerMaxWidth = 220.0;
  static const drawerIconSize = 40.0;
  static const loginFormWidth = 250.0;
  static const loginFormHeight = 380.0;
  static const appBarElevation = 50.0;
}

///
///Classe pour définir des styles de texte personnalisés
///
class MaderaTextStyles {
  const MaderaTextStyles();

  static const TextStyle appBarTitle = const TextStyle(
    color: MaderaColors.textHeaderColor,
    fontFamily: FontNameDefault,
    fontWeight: FontWeight.w900,
    fontSize: 26.0,
  );

  static const TextStyle defaultTextStyle = TextStyle(
    color: Colors.black,
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
