import 'package:flutter/material.dart';

///
/// TODO Provider permettant de gérer l'état de la synchronisation avec la base de donnée distante
/// TODO Permet également de gérer la sauvegarde locale
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class MaderaDB with ChangeNotifier {
  String _lastSyncDate;

  String get lastSyncDate => _lastSyncDate ??= '2019-12-02 23:00:00';
}
