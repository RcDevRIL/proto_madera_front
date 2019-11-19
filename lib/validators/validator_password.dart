import 'dart:async';

//http://www.expreg.com/memo.php
//const String _kMin8CharsOneLetterOneNumber = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
//const String _kMin8CharsOneLetterOneNumberOnSpecialCharacter = r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$";
//const String _kMin8CharsOneUpperLetterOneLowerLetterOnNumber = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
//const String _kMin8Max10OneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";

const String _kMin8CharsOneUpperOneLowerOneNumberOneSpecial =
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";

class PasswordValidator {
  final StreamTransformer<String, String> validatePassword =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    //final RegExp passwordExp =
    new RegExp(_kMin8CharsOneUpperOneLowerOneNumberOneSpecial);

    //if (!passwordExp.hasMatch(password)){
    if (password.length < 5) {
      sink.addError('Password must be greater than 4');
    } else {
      sink.add(password);
    }
  });
}
