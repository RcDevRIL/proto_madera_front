import 'dart:async';

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
