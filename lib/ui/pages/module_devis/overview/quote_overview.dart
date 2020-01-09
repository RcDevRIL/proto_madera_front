import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto_madera_front/data/models/projet_with_client.dart';
import 'package:proto_madera_front/data/providers/provider_projet.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderBdd;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/widgets/common/madera_dialog.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold, MaderaTableCell;
import 'package:proto_madera_front/ui/widgets/madera_button.dart';
import 'package:provider/provider.dart';

///
/// Overview list of saved projects for current user
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class QuoteOverview extends StatefulWidget {
  static const routeName = '/quoteOverview';

  @override
  _QuoteOverviewState createState() => _QuoteOverviewState();
}

class _QuoteOverviewState extends State<QuoteOverview> {
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
      child: Consumer<MaderaNav>(
        builder: (_, mN, c) => FutureBuilder(
          future: Provider.of<ProviderBdd>(context).initProjetData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Problème lors de la récupération des données'),
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                ],
              );
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  width: 2500,
                  height: 665,
                  child: DataTable(
                    columnSpacing: 0,
                    headingRowHeight: 100,
                    dataRowHeight: 100,
                    columns: [
                      DataColumn(
                        label: MaderaTableCell(
                          textCell: 'Date de création',
                          backgroundColor: cTheme.MaderaColors.appBarMainColor,
                          cellFontSize: 20,
                          height: 100,
                          width: 250,
                        ),
                      ),
                      DataColumn(
                        label: MaderaTableCell(
                          textCell: 'Ref.client',
                          backgroundColor: cTheme.MaderaColors.appBarMainColor,
                          cellFontSize: 20,
                          height: 100,
                          width: 250,
                        ),
                      ),
                      DataColumn(
                        label: MaderaTableCell(
                          textCell: 'Ref. projet',
                          backgroundColor: cTheme.MaderaColors.appBarMainColor,
                          cellFontSize: 20,
                          height: 100,
                          width: 250,
                        ),
                      ),
                      DataColumn(
                        label: MaderaTableCell(
                          textCell: 'Nom du projet',
                          backgroundColor: cTheme.MaderaColors.appBarMainColor,
                          cellFontSize: 20,
                          height: 100,
                          width: 250,
                        ),
                      ),
                    ],
                    rows: _createRows(context, snapshot),
                  ),
                ),
              );
            } else {
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void showPopup(BuildContext context, IconData icon, String title, Widget body,
      Color color, List<Widget> actions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MaderaDialog(
          titleAndIconColor: color,
          title: title,
          icon: icon,
          body: body,
          actions: actions,
        );
      },
    );
  }
}

List<DataRow> _createRows(BuildContext context, AsyncSnapshot snapshot) {
  return snapshot.data
      .map<DataRow>(
        (ProjetWithClient projetWithClient) => DataRow(
          onSelectChanged: (bool selected) {
            if (selected) {
              //TODO passer directement l'objet projetWithClient ?
              if (Provider.of<ProviderBdd>(context).editProjetIndex ==
                  projetWithClient.projet.refProjet) {
                Provider.of<ProviderBdd>(context).loadProjetEdit(null);
              } else {
                Provider.of<ProviderBdd>(context)
                    .loadProjetEdit(projetWithClient.projet.refProjet);
              }
              //Provider.of<MaderaNav>(context).redirectToPage(context, PageDevis(${projetWithClient.projet.projetId));
            }
          },
          selected: Provider.of<ProviderBdd>(context).editProjetIndex ==
              projetWithClient.projet.refProjet,
          cells: <DataCell>[
            DataCell(
              MaderaTableCell(
                textCell:
                    '${projetWithClient.projet.dateProjet.day}/${projetWithClient.projet.dateProjet.month}/${projetWithClient.projet.dateProjet.year}',
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell:
                    '${projetWithClient.client.nom} ${projetWithClient.client.prenom}',
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell: projetWithClient.projet.refProjet,
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell: projetWithClient.projet.nomProjet,
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
          ],
        ),
      )
      .toList();
}
