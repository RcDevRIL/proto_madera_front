import 'dart:async';

///
/// Class to handle validation of a text input
///  - Configure error message
///  - Propagate input if condition(s) OK
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1-RELEASE
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
