import 'package:proto_madera_front/bloc_helpers/bloc_provider.dart';
import 'package:proto_madera_front/bloc_widgets/bloc_state_builder.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_bloc.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_state.dart';
import 'package:proto_madera_front/ui/pages/authentication_page.dart';
import 'package:proto_madera_front/ui/pages/home-page.dart';
import 'package:flutter/material.dart';

class DecisionPage extends StatefulWidget {
  static const routeName = '/decision';
  @override
  DecisionPageState createState() {
    return new DecisionPageState();
  }
}

class DecisionPageState extends State<DecisionPage> {
  AuthenticationState oldAuthenticationState;

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocEventStateBuilder<AuthenticationState>(
        bloc: bloc,
        builder: (BuildContext context, AuthenticationState state) {
          if (state != oldAuthenticationState) {
            oldAuthenticationState = state;

            if (state.isAuthenticated) {
              _redirectToPage(context, HomePage());
            } else if (state.isAuthenticating || state.hasFailed) {
              //do nothing
            } else {
              _redirectToPage(context, AuthenticationPage());
            }
          }

          // This page does not need to display anything since it will
          // always remain behind any active page (and thus 'hidden').
          return Container();
        });
  }

  void _redirectToPage(BuildContext context, Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MaterialPageRoute newRoute =
          MaterialPageRoute(builder: (BuildContext context) => page);

      Navigator.of(context)
          .pushAndRemoveUntil(newRoute, ModalRoute.withName('/decision'));
    });
  }
}
