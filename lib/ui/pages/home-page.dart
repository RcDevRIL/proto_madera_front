import 'package:flutter/material.dart';
import 'package:proto_madera_front/bloc_helpers/bloc_provider.dart';
import 'package:proto_madera_front/bloc_widgets/bloc_state_builder.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_bloc.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_state.dart';
import 'package:proto_madera_front/ui/pages/widgets/log_out_button.dart';
import 'package:proto_madera_front/ui/pages/widgets/pending_action.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("HOME PAGE"),
            centerTitle: false,
            leading: Container(),
            actions: <Widget>[
              LogOutButton(),
            ],
          ),
          body: Container(
            child: BlocEventStateBuilder<AuthenticationState>(
                bloc: bloc,
                builder: (BuildContext context, AuthenticationState state) {
                  if (state.isAuthenticating) {
                    return PendingAction();
                  }

                  if (!state.isAuthenticated) {
                    return Container(
                        color: Colors.black87,
                        child: Center(
                            child: Icon(
                          Icons.check_circle,
                          color: Colors.cyan,
                          size: 50.0,
                        )));
                  }

                  return Stack(
                    children: <Widget>[
                      Center(
                        child: Text("PAGE PRINCIPALE"),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
