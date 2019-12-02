import 'package:flutter/material.dart';

class MaderaDB with ChangeNotifier {
  String _lastSyncDate;

  String get lastSyncDate => _lastSyncDate ??= '2019-12-02 23:00:00';
}
