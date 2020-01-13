import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:proto_madera_front/data/providers/provider_synchro.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart'
    show MaderaScaffold;
import 'package:provider/provider.dart';

///
/// Overview list of saved projects for current user
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class ViewPdf extends StatefulWidget {
  static const routeName = '/quoteOverview';

  @override
  _ViewPdf createState() => _ViewPdf();
}

class _ViewPdf extends State<ViewPdf> {
  final log = Logger();
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
    return MaderaScaffold(
      passedContext: context,
      child: PDFViewerScaffold(
        path: Provider.of<ProviderSynchro>(context).file.path,
      ),
    );
  }
}
