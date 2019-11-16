import 'dart:async';

//const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
const String _kRule = r"^[a-zA-Z0-9_.+-]*@[a-zA-Z0-9-]*\.[a-zA-Z0-9-.]*$";

class EmailValidator {
  final StreamTransformer<String, String> validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kRule);

    if (/*(email.contains('@') && email.contains('.'))*/ !emailExp
            .hasMatch(email) &&
        email.isNotEmpty) {
      sink.addError('Enter a valid email');
    } else {
      sink.add(email);
    }
  });
}
