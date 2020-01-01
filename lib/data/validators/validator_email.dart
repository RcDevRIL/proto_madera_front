import 'dart:async';

const String _kRule = r"^[a-z]+$";

///
/// Classe permettant de gérer la validation d'un champ.
///  - Configure le message d'erreur à afficher sous le champ texte
///  - Propage le paramètre si condition(s) OK
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-PRE-RELEASE
class EmailValidator {
  final StreamTransformer<String, String> validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kRule);

    if (!emailExp.hasMatch(email) && email.isNotEmpty) {
      sink.addError('Enter a valid email');
    } else {
      sink.add(email);
    }
  });
}
