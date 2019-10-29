/**
 * FORK D'UN PROJET OPEN SOURCE
 * 
 * AUTEUR :
 *      Didier BOELENS - (https://github.com/boeledi/blocs)
 */
import 'package:proto_madera_front/bloc_helpers/bloc_event_state.dart';
import 'package:proto_madera_front/blocs/application_initialization/application_initialization_event.dart';
import 'package:proto_madera_front/blocs/application_initialization/application_initialization_state.dart';

class ApplicationInitializationBloc extends BlocEventStateBase<
    ApplicationInitializationEvent, ApplicationInitializationState> {
  ApplicationInitializationBloc()
      : super(
          initialState: ApplicationInitializationState.notInitialized(),
        );

  @override
  Stream<ApplicationInitializationState> eventHandler(
      ApplicationInitializationEvent event,
      ApplicationInitializationState currentState) async* {
    if (!currentState.isInitialized) {
      yield ApplicationInitializationState.notInitialized();
    }

    if (event.type == ApplicationInitializationEventType.start) {
      for (int progress = 0; progress < 101; progress += 1) {
        await Future.delayed(const Duration(milliseconds: 20));
        yield ApplicationInitializationState.progressing(progress);
      }
    }

    if (event.type == ApplicationInitializationEventType.initialized) {
      yield ApplicationInitializationState.initialized();
    }
  }
}
