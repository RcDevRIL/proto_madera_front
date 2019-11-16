import 'package:flutter/material.dart';

// Default Font Family
const String FontNameDefault = 'Poppins';

class Colors {
  const Colors();

  static const Color appBarMainColor = Color.fromRGBO(109, 243, 115, 0.33);
  static const Color iconsMainColor = Color.fromRGBO(39, 72, 0, 1.0);
  static const Color customBlue = const Color(0xFF0097A7);
  static const Color lightBlue = const Color(0xFF56C8D8);
  static const Color darkBlue = const Color(0xFF006978);
  static const Color customBrown = const Color(0xFF5D4037);
  static const Color lightBrown = const Color(0xFF8B6B61);
  static const Color darkBrown = const Color(0xFF321911);
  static const Color primaryTextColor = const Color(0xFF000000);
  static const Color secondaryTextColor = const Color(0xFFFFFFFF);

  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);

  static const Color patientCard2 = const Color(0xFF434273);
  static const Color patientCard = const Color(0xFF8685E5);
  static const Color patientListBackground = const Color(0xFF3E3963);
  static const Color patientPageBackground = const Color(0xFF736AB7);
  static const Color patientTitle = const Color(0xFFFFFFFF);
  static const Color patientLocation = const Color(0x66FFFFFF);
  static const Color patientDistance = const Color(0x66FFFFFF);
  static const Color patientResumePageCard = const Color(0xff006978);
  static const Color patientResumePageCardBorder = const Color(0xff56c8d8);
}

class Dimens {
  const Dimens();

  static const patientWidth = 150.0;
  static const patientHeight = 150.0;
}

class TextStyles {
  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w600,
      fontSize: 36.0);

  static const TextStyle patientTitle = const TextStyle(
      color: Colors.patientTitle,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w600,
      fontSize: 24.0);

  static const TextStyle patientLocation = const TextStyle(
      color: Colors.patientLocation,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w300,
      fontSize: 14.0);

  static const TextStyle patientDistance = const TextStyle(
      color: Colors.patientDistance,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w300,
      fontSize: 12.0);
}

const AppBarTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: 16.0,
  color: Colors.appBarTitle,
);
