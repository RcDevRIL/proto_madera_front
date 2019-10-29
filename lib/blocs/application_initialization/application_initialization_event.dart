/**
 * FORK D'UN PROJET OPEN SOURCE
 * 
 * AUTEUR :
 *      Didier BOELENS - (https://github.com/boeledi/blocs)
 */
import 'package:proto_madera_front/bloc_helpers/bloc_event_state.dart';

class ApplicationInitializationEvent extends BlocEvent {
  final ApplicationInitializationEventType type;

  ApplicationInitializationEvent({
    this.type: ApplicationInitializationEventType.start,
  }) : assert(type != null);
}

enum ApplicationInitializationEventType {
  start,
  initialized,
}
