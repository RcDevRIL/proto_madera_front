import 'package:proto_madera_front/bloc_helpers/bloc_provider.dart';
import 'package:proto_madera_front/bloc_widgets/bloc_state_builder.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_bloc.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_event.dart';
import 'package:proto_madera_front/blocs/authentication/authentication_state.dart';
import 'package:proto_madera_front/blocs/authentication/login_form_bloc.dart';
import 'package:proto_madera_front/ui/pages/widgets/pending_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  AuthenticationPageState createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  LoginFormBloc _loginFormBloc;

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginFormBloc = LoginFormBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController?.dispose();
    _passwordController?.dispose();
    _loginFormBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc bloc = BlocProvider.of<AuthenticationBloc>(context);
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: Text("Test"),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Bienvenue sur l'application métier Madera !",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(39, 72, 0, 1.0),
                  ),
                ),
                Image(
                  image: AssetImage("assets/img/logo-madera.png"),
                ),
              ],
            ),
          ),
          body: Container(
            child: BlocEventStateBuilder<AuthenticationState>(
              bloc: bloc,
              builder: (BuildContext context, AuthenticationState state) {
                if (state.isAuthenticating) {
                  return PendingAction();
                }

                if (state.isAuthenticated) {
                  return Container(
                      color: Colors.black87,
                      child: Center(
                          child: Icon(
                        Icons.check_circle,
                        color: Colors.cyan,
                        size: 50.0,
                      )));
                }

                List<Widget> children = <Widget>[];

                children.add(Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Color.fromRGBO(39, 72, 0, 1.0),
                    ),
                    Text(
                      "Identifiant",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(39, 72, 0, 1.0),
                      ),
                    ),
                  ],
                ));

                children.add(
                  SizedBox(
                    height: 24.0,
                  ),
                );

                children.add(StreamBuilder<Object>(
                    stream: _loginFormBloc.emailValidation,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: /* MediaQuery.of(context).size.width / 2 */ 200.0,
                          height: 80.5,
                          child: TextField(
                            onChanged: _loginFormBloc.onEmailChanged,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Enter email",
                              labelText: "Email",
                              errorText: snapshot.error,
                            ),
                          ),
                        ),
                      );
                    }));
                children.add(
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.lock,
                        color: Color.fromRGBO(39, 72, 0, 1.0),
                      ),
                      Text(
                        "Mot de passe",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color.fromRGBO(39, 72, 0, 1.0),
                        ),
                      ),
                    ],
                  ),
                );

                children.add(
                  SizedBox(
                    height: 24.0,
                  ),
                );

                children.add(StreamBuilder<Object>(
                    stream: _loginFormBloc.passwordValidation,
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: /* MediaQuery.of(context).size.width / 2 */ 200.0,
                          height: 80.5,
                          child: TextField(
                            onChanged: _loginFormBloc.onPasswordChanged,
                            controller: _passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusColor: Colors.white,
                              border: OutlineInputBorder(),
                              hintText: "Enter password",
                              labelText: "Password",
                              errorText: snapshot.error,
                            ),
                          ),
                        ),
                      );
                    }));

                children.add(StreamBuilder<bool>(
                    stream: _loginFormBloc.login,
                    builder: (context, snapshot) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            child: Text('Connexion'),
                            color: Color.fromRGBO(139, 195, 74, 1.0),
                            textColor: Colors.white,
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: Color.fromRGBO(117, 117, 117, 0.5),
                                width: 2.0,
                              ),
                            ),
                            onPressed: (snapshot.hasData &&
                                    snapshot.data == true)
                                ? () {
                                    bloc.emitEvent(AuthenticationEventLogin(
                                        event: LoginEventType.working,
                                        name: _emailController.text,
                                        password: _passwordController.text));
                                  }
                                : null,
                          ));
                    }));
                // Display a text if the authentication failed
                if (state.hasFailed) {
                  children.add(
                    Text('Authentication failure!'),
                  );
                }

                return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage("assets/img/madera.JPG")),
                          ),
                        ),
                      ),
                      Center(
                        child: SingleChildScrollView(
                          child: Container(
                            width: 250,
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              // gradient: LinearGradient(
                              //   colors: <Color>[Colors.white, Colors.black87],
                              //   stops: <double>[0.1, 0.9],
                              // ),
                            ),
                            child: Column(
                              children: children,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

//                // Button to fake the authentication (success)
//                children.add(
//                  ListTile(
//                      title: RaisedButton(
//                        child: Text('Log in (success)'),
//                        onPressed: () {
//                            bloc.emitEvent(AuthenticationEventLogin(name: 'Didier'));
//                        },
//                      ),
//                    ),
//                );

//                // Button to fake the authentication (failure)
//                children.add(
//                  ListTile(
//                      title: RaisedButton(
//                        child: Text('Log in (failure)'),
//                        onPressed: () {
//                            bloc.emitEvent(AuthenticationEventLogin(name: 'failure'));
//                        },
//                      ),
//                    ),
//                );

//                // Button to redirect to the registration page
//                children.add(
//                  ListTile(
//                    title: RaisedButton(
//                      child: Text('Register'),
//                      onPressed: () {
//                        Navigator.of(context)
//                            .pushNamed('/register');
//                      },
//                    ),
//                  ),
//                );
