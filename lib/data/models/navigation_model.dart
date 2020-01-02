import 'package:flutter/material.dart';

///
/// Modèle permettant de lier une page à un icône
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class NavigationModel {
  final String title;
  final IconData iconData;
  const NavigationModel({this.iconData, this.title});
}

const List<NavigationModel> navigationItems = [
  NavigationModel(title: "Accueil", iconData: Icons.apps),
  NavigationModel(title: "Outil Devis", iconData: Icons.assignment),
  NavigationModel(title: "Suivi Devis", iconData: Icons.search),
  NavigationModel(title: "Notifications", iconData: Icons.notifications),
  NavigationModel(title: "Settings", iconData: Icons.settings),
];