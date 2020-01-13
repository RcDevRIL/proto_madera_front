import 'package:flutter/material.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';

import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show
        FailureIcon,
        LabelledIcon,
        MaderaButton,
        MaderaCard,
        MaderaScaffold,
        PendingAction;
import 'package:provider/provider.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Profile user page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class UserProfilePage extends StatefulWidget {
  static const routeName = '/bell';

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerSize = Provider.of<ProviderSize>(context);
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        /** Centre de la page */
        child: FutureBuilder(
          future:
              Provider.of<ProviderBdd>(context).utilisateurDao.getLastUser(),
          builder: (c, s) {
            if (s.hasError)
              return FailureIcon();
            else if (s.hasData) {
              UtilisateurData user = s.data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: providerSize.quoteMaderaCardSmallHeight + 10,
                      backgroundColor: cTheme.MaderaColors.maderaBlueGreen,
                      foregroundColor: cTheme.MaderaColors.maderaAccentGreen,
                      child: Text('${user.login}'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Vos Informations',
                          style: cTheme.MaderaTextStyles.appBarTitle,
                        ),
                        Divider(
                          height: 12.0,
                          color: cTheme.MaderaColors.maderaBlueGreen,
                          thickness: 3.0,
                          indent: 150.0,
                          endIndent: 150.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaderaCard(
                              cardWidth: providerSize.quoteMaderaCardSmallWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('ID. utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.utilisateurId}'),
                              ),
                            ),
                            MaderaCard(
                              cardWidth:
                                  providerSize.quoteMaderaCardMediumWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('Login utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.login}'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaderaCard(
                              cardWidth: providerSize.quoteMaderaCardSmallWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('ID. utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.utilisateurId}'),
                              ),
                            ),
                            MaderaCard(
                              cardWidth:
                                  providerSize.quoteMaderaCardMediumWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('Login utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.login}'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaderaCard(
                              cardWidth: providerSize.quoteMaderaCardSmallWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('ID. utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.utilisateurId}'),
                              ),
                            ),
                            MaderaCard(
                              cardWidth:
                                  providerSize.quoteMaderaCardMediumWidth,
                              cardHeight:
                                  providerSize.quoteMaderaCardSmallHeight,
                              header: LabelledIcon(
                                icon: Icon(
                                  Icons.info,
                                  semanticLabel: 'ID',
                                  size: 24.0,
                                ),
                                text: Text('Login utilisateur:'),
                                mASize: MainAxisSize.min,
                              ),
                              child: Center(
                                child: Text('${user.login}'),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 12.0,
                          color: cTheme.MaderaColors.maderaBlueGreen,
                          thickness: 3.0,
                          indent: 150.0,
                          endIndent: 150.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            MaderaButton(
                              onPressed: () => Provider.of<MaderaNav>(context)
                                  .showPopup(
                                      context,
                                      Icons.exit_to_app,
                                      'Déconnexion',
                                      Text(
                                          'Voulez-vous vraiment vous déconnecter ?'),
                                      <Widget>[
                                    Row(
                                      children: <Widget>[
                                        MaderaButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text('Non'),
                                        ),
                                        MaderaButton(
                                          onPressed: () {
                                            Provider.of<ProviderSynchro>(
                                                    context)
                                                .refsLastSyncDate = null;
                                            Provider.of<ProviderSynchro>(
                                                    context)
                                                .dataLastSyncDate = null;
                                            Provider.of<ProviderLogin>(context)
                                                .logout();
                                            Provider.of<MaderaNav>(context)
                                                .redirectToPage(
                                                    context,
                                                    DecisionPage(),
                                                    ['true', 'logout']);
                                          },
                                          child: Text('Oui'),
                                        ),
                                      ],
                                    )
                                  ]),
                              child: Text('Déconnexion'),
                            ),
                            MaderaButton(
                              onPressed: () {
                                Provider.of<MaderaNav>(context)
                                    .showNothingYouCanDoPopup(
                                        context,
                                        Icons.info,
                                        'Oups !',
                                        'Essayez l\'autre bouton...',
                                        null);
                              },
                              child: Text('Déconnexion'),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return PendingAction();
            }
          },
        ),
      ),
    );
  }
}
