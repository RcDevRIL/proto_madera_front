import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:proto_madera_front/data/providers/provider_synchro.dart';
import 'package:proto_madera_front/data/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:provider/provider.dart';

///
/// Overview list of saved projects for current user
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.1.1
class ViewPdf extends StatefulWidget {
  static const routeName = '/quoteOverview';

  @override
  _ViewPdf createState() => _ViewPdf();
}

class _ViewPdf extends State<ViewPdf> {
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
    return Center(
      child: PDFViewerScaffold(
        appBar: AppBar(
          primary: true,
          title: Text(
            'Devis PDF',
            style: cTheme.MaderaTextStyles.appBarTitle,
          ),
          centerTitle: false,
          actions: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0.0), //override theme
              shape: Border.all(style: BorderStyle.none), //override theme
              onPressed: () => Provider.of<MaderaNav>(context)
                  .redirectToPage(context, HomePage(), null),
              child: Image(
                image: AssetImage('assets/img/logo-madera.png'),
              ),
            ),
          ],
        ),
        path: Provider.of<ProviderSynchro>(context).file != null
            ? Provider.of<ProviderSynchro>(context).file.path
            : _showError(context),
      ),
    );
  }

  _showError(BuildContext context) {
    Provider.of<MaderaNav>(context).showNothingYouCanDoPopup(
        context,
        Icons.warning,
        'Plateforme non supportée',
        'La vue PDF n\'est pas implémentée en version web!',
        null);
    return null;
  }
}
