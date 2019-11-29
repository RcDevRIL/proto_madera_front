import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/services/authentication/login_form_bloc.dart';
import 'package:proto_madera_front/ui/pages/home_page.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class AuthenticationPage extends StatefulWidget {
  static const routeName = '/auth';
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  LoginFormBloc _loginFormBloc;

  final log = Logger();

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
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).devicePixelRatio *
                        28), //taille de l'appBar
                decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          Color.fromRGBO(255, 255, 255, 0.5),
                          BlendMode.modulate),
                      fit: BoxFit.fitWidth,
                      image: AssetImage("assets/img/madera.JPG")),
                ),
              ),
              Center(
                child: Container(
                  width: cTheme.Dimens.loginFormWidth,
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
                    //   colors: <Color>[Colors.greenAccent, Colors.white],
                    //   stops: <double>[0.0, 0.2],
                    // ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: _buildForm(context),
                    ),
                  ),
                ),
              ),
              AppBarMadera(),
              //visiblement on ne peut pas le mettre dans le champ appBar du Scaffold.. alors voila !!
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildForm(BuildContext c) {
    List<Widget> children = <Widget>[];

    children.add(new LabelledIcon(
      icon: Icon(
        Icons.person,
        color: Color.fromRGBO(39, 72, 0, 1.0),
      ),
      text: Text(
        "Identifiant",
        style: TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(39, 72, 0, 1.0),
        ),
      ),
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
      LabelledIcon(
        icon: Icon(
          Icons.lock,
          color: Color.fromRGBO(39, 72, 0, 1.0),
        ),
        text: Text(
          "Mot de passe",
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(39, 72, 0, 1.0),
          ),
      ),
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

    children.add(
      StreamBuilder<bool>(
        stream: _loginFormBloc.login,
        builder: (context, snapshot) {
          return MaderaButton(
            onPressed: (snapshot.hasData && snapshot.data == true)
                ? () {
                    //TODO Emettre un évènement de connexion
                    //genre login(_emailController.text,_passwordController.text);
                    log.d("LOGIN EVENT");
                    Provider.of<MaderaNav>(context)
                        .redirectToPage(context, HomePage());
                  }
                : null,
            child: Text('Connexion'),
          );
        },
      ),
    );

    return children;
  }
}
