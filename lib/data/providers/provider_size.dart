import 'package:flutter/material.dart';

///
/// Provider to handle device screen size and store specific ui elements dimensions
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
class ProviderSize with ChangeNotifier {
  List<double> _sizeMedia = new List();
  double _gradientFrameWidth;
  double _floatingButtonWidth;
  double _quoteMaderaCardSmallWidth;
  double _quoteMaderaCardMediumWidth;
  double _quoteMaderaCardHightWidth;
  double _quoteMaderaCardSmallHeight;
  double _quoteMaderaCardMediumHeight;
  double _quoteMaderaCardHightHeight;
  double _overviewTableWidth;
  double _overviewTableHeight;
  double _addModuleMaderaCardWidth;
  double _productListBlankWidth;

  String _userTheme;

  void setConfigurationSize(BuildContext context) {
    _sizeMedia.add(MediaQuery.of(context).size.width);
    _sizeMedia.add(MediaQuery.of(context).size.height);
    _gradientFrameWidth = _sizeMedia.elementAt(0) - 200;
    _floatingButtonWidth = _sizeMedia.elementAt(0) - 50;
    _overviewTableWidth = (_sizeMedia.elementAt(0) - 35) / 100 * 80;
    _overviewTableHeight = _sizeMedia.elementAt(1) / 100 * 80;
    _quoteMaderaCardSmallWidth = _gradientFrameWidth / 100 * 15;
    _quoteMaderaCardMediumWidth = _gradientFrameWidth / 100 * 40;
    _quoteMaderaCardHightWidth = _gradientFrameWidth / 100 * 50;
    _quoteMaderaCardSmallHeight = (_sizeMedia.elementAt(1) - 100) / 100 * 10;
    _quoteMaderaCardMediumHeight = (_sizeMedia.elementAt(1) - 100) / 100 * 30;
    _quoteMaderaCardHightHeight = (_sizeMedia.elementAt(1) - 100) / 100 * 50;
    _addModuleMaderaCardWidth = _gradientFrameWidth / 100 * 25;
    _productListBlankWidth = _gradientFrameWidth / 100 * 10;
  }

  String get userTheme => _userTheme ?? 'Light';

  double get gradientFrameWidth => _gradientFrameWidth;
  double get floatingButtonWidth => _floatingButtonWidth;
  double get tableOverviewWidth => _overviewTableWidth;
  double get tableOverviewHeight => _overviewTableHeight;
  double get quoteMaderaCardSmallWidth => _quoteMaderaCardSmallWidth;
  double get quoteMaderaCardMediumWidth => _quoteMaderaCardMediumWidth;
  double get quoteMaderaCardHightWidth => _quoteMaderaCardHightWidth;
  double get quoteMaderaCardSmallHeight => _quoteMaderaCardSmallHeight;
  double get quoteMaderaCardMediumHeight => _quoteMaderaCardMediumHeight;
  double get quoteMaderaCardHightHeight => _quoteMaderaCardHightHeight;
  double get productListBlankWidth => _productListBlankWidth;
  double get addModuleMaderaCardWidth => _addModuleMaderaCardWidth;
  double get mediaWidth => _sizeMedia.elementAt(0);
  double get mediaHeight => _sizeMedia.elementAt(1);
}

/*/// TODO SUPPRIMER CETTE CLASSE ET RENDRE L'APPLICATION RESPONSIVE
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
  static const cardSizeXSmall = 160.0;
  static const cardSizeMedium = 821.0;
  static const cardSizeLarge = 980.0;
  static const cardHeight = 45.0;
  static const cardHeightMedium = 185.0;
  static const cardHeightLarge = 450.0;
  static const boxWidth = 250.0;
  static const boxWidthMedium = 350.0;
  static const boxHeight = 60.0;
}*/
