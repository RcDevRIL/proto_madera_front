import 'package:proto_madera_front/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent {
  final String name;
  final LoginEventType event;

  AuthenticationEvent({
    this.name: '',
    this.event: LoginEventType.none,
  });
}

class AuthenticationEventLogin extends AuthenticationEvent {
  final String password;
  final LoginEventType event;

  AuthenticationEventLogin({
    String name,
    this.event,
    this.password,
  }) : super(
          name: name,
        );
}

class AuthenticationEventLogout extends AuthenticationEvent {}

enum LoginEventType {
  none,
  working,
}
