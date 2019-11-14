import 'package:flutter/widgets.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  // Connexion à Spring Boot
  // Auth auth;
  String _user;
  Status _status = Status.Uninitialized;

  Status get status => _status;
  String get user => _user;

  
}