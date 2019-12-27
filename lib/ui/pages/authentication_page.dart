import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/services/authentication/login_form_bloc.dart';
import 'package:proto_madera_front/ui/pages/pages.dart' show HomePage;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show AppBarMadera, LabelledIcon, MaderaButton;
import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderLogin, ProviderSynchro;
import 'package:proto_madera_front/providers/http_status.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page d'authentification
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
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
          body: InkWell(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 12,
                  ), //taille de l'appBar
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
                onSubmitted: _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? (login) async => submit()
                    : null,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter login",
                  labelText: "Login",
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
                onSubmitted: _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? (password) async => submit()
                    : null,
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
          return MaderaButton(
            onPressed: () async {
              if ((snapshot.hasData && snapshot.data == true)) {
                submit();
              }
            },
            child: Text('Connexion'),
          );
        }));

    return children;
  }

  void submit() async {
    await Provider.of<ProviderLogin>(context)
        .connection(_emailController.text, _passwordController.text);
    switch (Provider.of<ProviderLogin>(context).getStatus) {
      case HttpStatus.AUTHORIZED:
        {
          //on ne synchronise que si la date de dernière synchro est antérieure à la date actuelle
          if (DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .isAfter(
                  Provider.of<ProviderSynchro>(context).refsLastSyncDate)) {
            Provider.of<ProviderSynchro>(context).synchroReferentiel().then(
                (b) => b
                    ? log.i('Synchro des référentiels effectuée')
                    : _showSynchroErrorPopup(context, 'synchroReferentiel'));
          } else
            log.i('Synchronisation des référentiels déjà effectuée!');
          if (DateTime(
                  DateTime.now().year, DateTime.now().month, DateTime.now().day)
              .isAfter(
                  Provider.of<ProviderSynchro>(context).dataLastSyncDate)) {
            Provider.of<ProviderSynchro>(context).synchroData().then((b) => b
                ? log.i('Synchro des données utilisateur effectuée')
                : _showSynchroErrorPopup(context, 'synchroData'));
          } else
            log.i('Synchronisation des référentiels déjà effectuée!');
          Provider.of<ProviderBdd>(context).initProjetData();
          Provider.of<MaderaNav>(context).redirectToPage(context, HomePage());
          //TODO Ajouter initData()
        }
        break;
      case HttpStatus.OFFLINE:
        {
          _showPopup(
              context, 'Erreur réseau', 'Le serveur n' ' est pas joignable.');
        }
        break;
      case HttpStatus.ONLINE:
        {
          _showPopup(context, 'Erreur d' 'authentification',
              'Le login et / ou le mot de passe sont incorrects');
        }
        break;
      case HttpStatus.UNAUTHORIZED:
        {
          _showPopup(context, 'Autorisation requise',
              'Les identifiants sont incorrects');
        }
        break;
      default:
        {
          _showPopup(
              context, 'Default', 'Oups! Ceci ne devrait pas arriver...');
        }
        break;
    }
  }

  void _showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '$title',
            style: TextStyle(color: Colors.red),
          ),
          content: Text('$message'),
          actions: <Widget>[
            MaderaButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSynchroErrorPopup(BuildContext context, String synchroTried) {
    switch (synchroTried) {
      case 'synchroReferentiel':
        showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('Erreur de synchronisation'),
            content: Text('Erreur lors de l'
                'appel à la méthode $synchroTried().'),
            actions: <Widget>[
              MaderaButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );

        break;
      case 'synchroData':
        showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('Erreur de synchronisation'),
            content: Text('Erreur lors de l'
                'appel à la méthode $synchroTried().'),
            actions: <Widget>[
              MaderaButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );

        break;
      default:
        showDialog(
          context: context,
          builder: (c) => AlertDialog(
            title: Text('Erreur de synchronisation'),
            content: Text('Erreur non référencée.'),
            actions: <Widget>[
              MaderaButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        break;
    }
  }
}
