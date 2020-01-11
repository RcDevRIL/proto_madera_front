import 'package:flutter/material.dart';

///
/// Model that enables to bind a page title to an icon (used for our drawer)
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class NavigationModel {
  final Key key;
  final String title;
  final IconData iconData;
  const NavigationModel({this.key, this.iconData, this.title});
}

const List<NavigationModel> navigationItems = [
  NavigationModel(
      key: Key('home-tile'), title: 'Accueil', iconData: Icons.apps),
  NavigationModel(
      key: Key('quote_tool-tile'),
      title: 'Outil Devis',
      iconData: Icons.assignment),
  NavigationModel(
      key: Key('quote_overview-tile'),
      title: 'Suivi Devis',
      iconData: Icons.search),
  NavigationModel(
      key: Key('notifications-tile'),
      title: 'Notifications',
      iconData: Icons.notifications),
  NavigationModel(
      key: Key('settings-tile'), title: 'Settings', iconData: Icons.settings),
];
