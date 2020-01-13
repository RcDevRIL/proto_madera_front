import 'package:flutter/material.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/providers.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show FailureIcon, MaderaScaffold, PendingAction;
import 'package:proto_madera_front/ui/widgets/common/quote_gradient_frame.dart';
import 'package:provider/provider.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Profile user page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
class UserProfilePage extends StatefulWidget {
  static const routeName = '/bell';

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _userName;
  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
    _userName = 'TEST NAME';
  }

  //added to prepare for scaling
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments;
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: GradientFrame(
          child: FutureBuilder(
            future:
                Provider.of<ProviderBdd>(context).utilisateurDao.getLastUser(),
            builder: (c, s) {
              if (s.hasError)
                return FailureIcon();
              else if (s.hasData) {
                UtilisateurData user = s.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 80.0,
                      backgroundColor: cTheme.MaderaColors.maderaBlueGreen,
                      foregroundColor: cTheme.MaderaColors.maderaAccentGreen,
                      child: Text('${user.login}'),
                    ),
                    Text('${user.toString()}'),
                  ],
                );
              } else {
                return PendingAction();
              }
            },
          ),
        ),
      ),
    );
  }
}
