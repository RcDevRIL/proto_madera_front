import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:proto_madera_front/ui/pages/widgets/log_out_button.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final log = Logger();

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context).settings.arguments;
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
          body: _buildHomePage(context),
        ),
      ),
    );
  }

  Widget _buildHomePage(BuildContext context) {
    return Container(
      child:
          /* BlocEventStateBuilder<AuthenticationState>(
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
 */
          Stack(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("PAGE PRINCIPALE"),
                RaisedButton(
                  onPressed: () {
                    log.d('COUCOU JE SUIS UN LOG');
                  },
                  child: Text("Log me"),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/settings");
                  },
                  child: Text("Lien vers Settings"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
