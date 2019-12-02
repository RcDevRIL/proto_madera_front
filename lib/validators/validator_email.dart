import 'dart:async';

const String _kRule = r"^[a-z]+$";

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
