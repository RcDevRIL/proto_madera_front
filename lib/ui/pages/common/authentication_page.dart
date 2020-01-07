import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/blocs/authentication/login_form_bloc.dart';
import 'package:proto_madera_front/ui/pages/pages.dart' show HomePage;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show AppBarMadera, LabelledIcon, MaderaButton, MaderaRoundedBox;
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd, ProviderLogin, ProviderSynchro;
import 'package:proto_madera_front/data/models/http_status.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Login page of our application
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
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
  /// Prevents the use of the 'back' button
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
                        image: AssetImage('assets/img/madera.JPG')),
                  ),
                ),
                Center(
                  child: MaderaRoundedBox(
                    boxWidth: cTheme.Dimens.loginFormWidth,
                    boxHeight: cTheme.Dimens.loginFormHeight,
                    edgeInsetsPadding: EdgeInsets.all(8.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: _buildForm(context),
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
        'Identifiant',
        style: TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(39, 72, 0, 1.0),
        ),
      ),
    ));

    children.add(StreamBuilder<Object>(
        stream: _loginFormBloc.emailValidation,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: /* MediaQuery.of(context).size.width / 2 */ 200.0,
              height: 80.5,
              child: TextField(
                key: Key('username'),
                onChanged: _loginFormBloc.onEmailChanged,
                onSubmitted: _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? (login) async => submit()
                    : null,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  errorStyle: Theme.of(context).textTheme.body1.apply(
                        fontSizeDelta: -6.0,
                        color: Colors.red,
                      ),
                  border: OutlineInputBorder(),
                  hintText: 'Enter login',
                  labelText: 'Login',
                  errorText: snapshot.error,
                ),
              ),
            ),
          );
        }));
    children.add(
      SizedBox(
        height: 24.0,
      ),
    );
    children.add(
      LabelledIcon(
        icon: Icon(
          Icons.lock,
          color: Color.fromRGBO(39, 72, 0, 1.0),
        ),
        text: Text(
          'Mot de passe',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromRGBO(39, 72, 0, 1.0),
          ),
        ),
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
                key: Key('password'),
                onChanged: _loginFormBloc.onPasswordChanged,
                onSubmitted: _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty
                    ? (password) async => submit()
                    : null,
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  errorStyle: Theme.of(context).textTheme.body1.apply(
                        fontSizeDelta: -6.0,
                        color: Colors.red,
                      ),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: 'Enter password',
                  labelText: 'Password',
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
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: MaderaButton(
              key: Key('connect'),
              onPressed: snapshot.hasData && snapshot.data == true
                  ? () async {
                      submit();
                      // Provider.of<MaderaNav>(context)
                      //     .redirectToPage(context, HomePage());
                    }
                  : null,
              child: Text('Connexion'),
            ),
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
          Provider.of<MaderaNav>(context)
              .redirectToPage(context, HomePage(), null);
          Provider.of<ProviderBdd>(context).initData();
        }
        break;
      case HttpStatus.OFFLINE:
        {
          Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
            context,
            Icons.warning,
            'Erreur réseau',
            'Le serveur n\'est pas joignable.',
          );
        }
        break;
      case HttpStatus.ONLINE:
        {
          Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
            context,
            Icons.warning,
            'Erreur d\'authentification',
            'Le login et / ou le mot de passe sont incorrects',
          );
        }
        break;
      case HttpStatus.UNAUTHORIZED:
        {
          Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
            context,
            Icons.warning,
            'Autorisation requise',
            'Les identifiants sont incorrects',
          );
        }
        break;
      default:
        {
          Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
            context,
            Icons.warning,
            'Default',
            'Oups! Ceci ne devrait pas arriver...',
          );
        }
        break;
    }
  }

  void _showSynchroErrorPopup(BuildContext context, String synchroTried) {
    Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
      context,
      Icons.warning,
      'Erreur de synchronisation',
      'Erreur lors de l'
          'appel à la méthode $synchroTried().',
    );
  }
}
