import 'package:flutter/material.dart';
import 'package:proto_madera_front/ui/pages/widgets/labelled_icon.dart';
import 'package:proto_madera_front/theme.dart' as cTheme;

class MaderaCard extends StatefulWidget {
  final String autoText;
  final String defaultText;
  final LabelledIcon labelledIcon;
  final double cardHeight;
  final double cardWidth;
  final int maxLine;
  final bool enable;
  final TextInputType textInputType;
  final TextEditingController textEditingController;

  //DateFormat('yyyy-MM-dd').format(DateTime.now()) // Va être généré automatiquement à l'avenir
  const MaderaCard({
    Key key,
    @required this.cardHeight,
    @required this.cardWidth,
    @required this.enable,
    @required this.labelledIcon,
    @required this.textInputType,
    @required this.defaultText,
    this.textEditingController,
    this.autoText,
    this.maxLine,
  }) : super(key: key);

  @override
  _MaderaCardState createState() => _MaderaCardState();
}

class _MaderaCardState extends State<MaderaCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (null != widget.autoText && null != widget.textEditingController)
      widget.textEditingController.text = widget.autoText;
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: cTheme.Colors.containerBackgroundLinearStart,
          style: BorderStyle.solid,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      color: Color.fromRGBO(224, 224, 224, 1.0),
      elevation: 8.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 6.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: widget.labelledIcon,
          ),
          SizedBox(height: 6.0),
          Container(
            width: widget.cardWidth,
            height: widget.cardHeight,
            decoration: BoxDecoration(
              color: cTheme.Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
            ),
            child: TextField(
              maxLines: widget.maxLine == null ? 1 : widget.maxLine,
              controller: widget.textEditingController != null
                  ? widget.textEditingController
                  : TextEditingController(
                      text: widget.autoText,
                    ),
              keyboardType: widget.textInputType,
              enabled: widget.enable,
              decoration: InputDecoration(
                hintText: widget.autoText != null ? null : widget.defaultText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
/**
 * Ici() j'aurais pensé ecrire le nom du client 
 * e.g.: DUPONT
 * Une liste de tous les clients qui ont un nom contenant "DUPONT" apparaitrait
 * Et au clic sur une des proposition, l'ID du client s'insère dans cet input
 * 
 * Comme cela quand on accéderait aux devis d'un client spécifique, on renseignerait
 * 
 */
//TODO Voir pour guider encore plus le commercial grâce aux données BDD
