import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart'
    show ProviderSize;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show GradientFrame, LabelledIcon, MaderaScaffold;
import 'package:proto_madera_front/theme.dart' as cTheme;

///
/// Page to provide some parameters for user
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
class SettingsPage extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String themeChoisi;
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
    //final args = ModalRoute.of(context).settings.arguments;
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: GradientFrame(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Evolution des paiements échelonnés',
                  style: cTheme.MaderaTextStyles.appBarTitle,
                ),
                Divider(
                  height: 12.0,
                  color: cTheme.MaderaColors.maderaBlueGreen,
                  thickness: 1.0,
                  indent: 150.0,
                  endIndent: 150.0,
                ),
                Image(image: AssetImage('assets/img/echeancier.PNG')),
                Divider(
                  height: 12.0,
                  color: cTheme.MaderaColors.maderaBlueGreen2,
                  thickness: 1.0,
                  indent: 150.0,
                  endIndent: 150.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LabelledIcon(
                      icon: Icon(Icons.palette),
                      text: Text(
                        'Thème de l\'application:',
                        style: cTheme.MaderaTextStyles.appBarTitle
                            .apply(fontSizeDelta: -8.0),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      height: 50.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        focusColor: Colors.white,
                        value: themeChoisi,
                        style: cTheme.MaderaTextStyles.appBarTitle
                            .apply(fontSizeDelta: -8),
                        hint: Provider.of<ProviderSize>(context).userTheme !=
                                null
                            ? Text(
                                '${Provider.of<ProviderSize>(context).userTheme}')
                            : Text('Sélectionnez un thème'),
                        icon: Icon(Icons.arrow_drop_down,
                            color: cTheme.MaderaColors.maderaBlueGreen2),
                        iconSize: 30,
                        elevation: 16,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        items: ['Light', 'Dark (à venir)']
                            .map<DropdownMenuItem<String>>(
                                (String theme) => DropdownMenuItem<String>(
                                      value: theme,
                                      child: Text(theme),
                                    ))
                            .toList(),
                        onChanged: (String newValue) {
                          setState(() => themeChoisi = newValue);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
