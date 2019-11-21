/**
 * Inspired from "Flutter: Firebase Login Using Provider: package"
 * https://medium.com/flutter-community/flutter-firebase-login-using-provider-package-54ee4e5083c7
 * 
 * Author :
 *      Atif Siddiqui
 * 
 * 
 * Source Code : https://github.com/itsatifsiddiqui/providerLogin
 */

import 'package:flutter/cupertino.dart';

enum Status {
  Uninitialized, // Au moment du splashScreen
  Unauthenticated, // Sur la page de login
  Authenticating, // Lors du clic sur le bouton "Connexion"
  Authenticated, // Arrivé sur la Home Page
}

class ProviderLogin with ChangeNotifier {
  String _user;
  Status _status = Status.Uninitialized;

  Status get status => _status;
  String get user => _user;

  Future<bool> signIn(String login, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      // TODO: Appel API pour connexion avec login + password (utiliser await car c'est de l'asynchrone)
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    // TODO: Appel API déconnexion
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  /// Ici cette fonction devrait être appelée à chaque fois que le statut de l'utilisateur est changé
  /// On a 2 possibilités si on arrive a avoir l'utilisateur ou pas :
  /// Unauthenticated si l'utilisateur n'existe pas
  /// Authenticated si l'utilisateur existe
  /// Et on utilise notifyListeners quoi qu'il arrive pour informer l'UI des changements opérés
  Future<void> onAuthStateChanged(String user) async {
    if (user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }
}
