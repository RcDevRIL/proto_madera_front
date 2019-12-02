import 'package:flutter/material.dart';

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
