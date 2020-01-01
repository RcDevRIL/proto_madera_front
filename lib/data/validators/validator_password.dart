import 'dart:async';

///
/// Classe permettant de gérer la validation d'un champ.
///  - Configure le message d'erreur à afficher sous le champ texte
///  - Propage le paramètre si condition(s) OK
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class PasswordValidator {
  final StreamTransformer<String, String> validatePassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length < 5) {
      sink.addError('Password must be greater than 4');
    } else {
      sink.add(password);
    }
  });
}
