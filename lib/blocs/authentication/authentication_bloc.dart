/**
 * FORK D'UN PROJET OPEN SOURCE
 * 
 * AUTEUR :
 *      Didier BOELENS - (https://github.com/boeledi/blocs)
 */
import 'package:proto_madera_front/bloc_helpers/bloc_event_state.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_event.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_state.dart';

class AuthenticationBloc
    extends BlocEventStateBase<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          initialState: AuthenticationState.notAuthenticated(),
        );

  @override
  Stream<AuthenticationState> eventHandler(
      AuthenticationEvent event, AuthenticationState currentState) async* {
    if (event is AuthenticationEventLogin) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      await Future.delayed(const Duration(seconds: 2));

      // Inform that we have successfuly authenticated, or not
      if (event.name == "failure") {
        yield AuthenticationState.failure();
      } else {
        yield AuthenticationState.authenticated(event.name);
      }
    }

    if (event is AuthenticationEventLogout) {
      // Inform that we are proceeding with the authentication
      yield AuthenticationState.authenticating();

      // Simulate a call to the authentication server
      await Future.delayed(const Duration(seconds: 2));

      //Inform that we are not authenticated anymore
      yield AuthenticationState.notAuthenticated();
    }
  }
}
