import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/providers/providers.dart'
    show MaderaNav, ProviderBdd;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/widgets/custom_widgets.dart'
    show MaderaScaffold, MaderaTableCell;
import 'package:provider/provider.dart';

///
/// Page de "Suivi des devis enregistrés"
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-RELEASE
class QuoteOverview extends StatefulWidget {
  static const routeName = '/quoteOverview';

  @override
  _QuoteOverviewState createState() => _QuoteOverviewState();
}

class _QuoteOverviewState extends State<QuoteOverview> {
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
        child: MaderaScaffold.noAdd(
          passedContext: context,
          child: Consumer<MaderaNav>(
            builder: (_, mN, c) => StreamBuilder(
              stream: Provider.of<ProviderBdd>(context).initProjetData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.hasError) {
                  return Text('Problème lors de la récupération des données');
                } else {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: cTheme.Colors.primaryTextColor)),
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
                              backgroundColor: cTheme.Colors.appBarMainColor,
                              cellFontSize: 20,
                              height: 100,
                              width: 250,
                            ),
                          ),
                          DataColumn(
                            label: MaderaTableCell(
                              textCell: 'Ref.client',
                              backgroundColor: cTheme.Colors.appBarMainColor,
                              cellFontSize: 20,
                              height: 100,
                              width: 250,
                            ),
                          ),
                          DataColumn(
                            label: MaderaTableCell(
                              textCell: 'Ref. projet',
                              backgroundColor: cTheme.Colors.appBarMainColor,
                              cellFontSize: 20,
                              height: 100,
                              width: 250,
                            ),
                          ),
                          DataColumn(
                            label: MaderaTableCell(
                              textCell: 'Nom du projet',
                              backgroundColor: cTheme.Colors.appBarMainColor,
                              cellFontSize: 20,
                              height: 100,
                              width: 250,
                            ),
                          ),
                        ],
                        rows: _createRows(snapshot),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

List<DataRow> _createRows(AsyncSnapshot snapshot) {
  List<DataRow> listRows = snapshot.data
      .map<DataRow>(
        (ProjetData projetData) => DataRow(
          cells: <DataCell>[
            DataCell(
              MaderaTableCell(
                textCell:
                    '${projetData.dateProjet.day}/${projetData.dateProjet.month}/${projetData.dateProjet.year}',
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell: projetData.clientId.toString(),
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell: projetData.refProjet,
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
            DataCell(
              MaderaTableCell(
                textCell: projetData.nomProjet,
                cellFontSize: 18,
                height: 100,
                width: 250,
              ),
            ),
          ],
        ),
      )
      .toList();
  return listRows;
}
