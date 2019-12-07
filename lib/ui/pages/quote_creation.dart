import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/ui/pages/quote.dart';
import 'package:proto_madera_front/ui/pages/widgets/madera_button.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/providers/provider-navigation.dart';
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class QuoteCreation extends StatefulWidget {
  static const routeName = '/quote_create';

  @override
  _QuoteCreationState createState() => _QuoteCreationState();
}

class _QuoteCreationState extends State<QuoteCreation> {
  final log = Logger();

  ///
  /// Prevents the use of the "back" button
  ///
  Future<bool> _onWillPopScope() async {
    return false;
  }

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
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(cTheme.Dimens.drawerMinWitdh,
                    MediaQuery.of(context).size.height / 12, 0, 0),
                child: Center(
                  child: Consumer<MaderaNav>(
                    builder: (context, mN, w) => Container(
                      width: cTheme.Dimens.containerWidth,
                      height: cTheme.Dimens.containerHeight,
                      color: cTheme.Colors.containerBackground,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: Text("Devis"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    LabelledIcon(
                                      icon: Icon(Icons.calendar_today),
                                      text: Text("Date de création"),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      color: Colors.grey[200],
                                      width: cTheme.Dimens.cardSizeSmall,
                                      height: cTheme.Dimens.cardHeight,
                                      child: TextField(
                                        controller: TextEditingController(text: "D-0945194"), // Va être généré automatiquement à l'avenir
                                        keyboardType: TextInputType.text,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    LabelledIcon(
                                      icon: Icon(Icons.person),
                                      text: Text("ID. Client"),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      color: Colors.grey[200],
                                      width: cTheme.Dimens.cardSizeMedium,
                                      height: cTheme.Dimens.cardHeight,
                                      child: TextField(
                                        /**
                                         * Ici j'aurais pensé ecrire le nom du client
                                         * e.g.: DUPONT
                                         * Une liste de tous les clients qui ont un nom contenant "DUPONT" apparaitrait
                                         * Et au clic sur une des proposition, l'ID du client s'insère dans cet input
                                         * 
                                         * Comme cela quand on accéderait aux devis d'un client spécifique, on renseignerait
                                         */
                                        controller: TextEditingController(text: "C-018465454"), // Va être généré automatiquement à l'avenir
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: LabelledIcon(
                                      icon: Icon(Icons.info),
                                      text: Text("ID. Projet"),
                                    ),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      color: Colors.grey[200],
                                      width: cTheme.Dimens.cardSizeLarge,
                                      height: cTheme.Dimens.cardHeight,
                                      child: TextField(
                                        controller: TextEditingController(text: "P-01655651"),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: LabelledIcon(
                                      icon: Icon(Icons.info),
                                      text: Text("Description Projet"),
                                    ),
                                    ),
                                    SizedBox(height: 6.0),
                                    Container(
                                      color: Colors.grey[200],
                                      width: cTheme.Dimens.cardSizeLarge,
                                      height: cTheme.Dimens.cardHeightLarge,
                                      child: TextField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.bottomRight,
                                child: MaderaButton(
                                  onPressed: () {
                                    log.d("Quote Creation");
                                    Provider.of<MaderaNav>(context)
                                        .redirectToPage(context, Quote());
                                  },
                                  child: LabelledIcon(
                                    mASize: MainAxisSize.min,
                                    icon: Icon(Icons.check),
                                    text: Text("Valider"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: cTheme.Dimens.drawerMinWitdh),
                child: AppBarMadera(),
              ),
              CustomDrawer(),
            ],
          ),
        ),
      ),
    );
  }
}
