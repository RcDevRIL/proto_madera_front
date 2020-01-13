import 'dart:async';

const String _kRule = r'^[a-z]+$';

///
/// Class to handle validation of a text input
///  - Configure error message
///  - Propagate input if condition(s) OK
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
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
