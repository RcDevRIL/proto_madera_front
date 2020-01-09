import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_bdd.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/pages.dart';
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

///
/// Page to create/edit a module of current product
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class AddModule extends StatefulWidget {
  static const routeName = '/add_module';

  @override
  _AddModuleState createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  final dataKey = GlobalKey();
  final log = Logger();
  String dropdownValueModule;
  String dropdownValueNature;
  String dropdownValueAngle;
  ScrollController _formScrollController;
  bool isEditing;
  bool canValidateForm;

  //added to prepare for scaling
  @override
  void initState() {
    super.initState();
    dropdownValueModule = 'Sélectionnez un module';
    dropdownValueNature = 'Sélectionnez une nature de module...';
    _formScrollController = ScrollController();
  }

  //added to prepare for scaling
  @override
  void dispose() {
    _formScrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var providerProjet = Provider.of<ProviderProjet>(context);
    var providerBdd = Provider.of<ProviderBdd>(context);
    ((providerProjet.editModuleIndex != providerProjet.produitModules.length) &&
            (providerProjet.produitModules.length != 0))
        ? isEditing = true
        : isEditing = false;
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
                isEditing
                    ? 'Modification du module n°${providerProjet.editModuleIndex + 1}'
                    : 'Ajouter un module',
                style: cTheme.MaderaTextStyles.appBarTitle
                    .copyWith(fontSize: 32.0)),
            GradientFrame(
              child: SingleChildScrollView(
                controller: _formScrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    isEditing ? Container() : _createDropDowns(providerBdd),
                    MaderaCard(
                      cardWidth: 450.0,
                      cardHeight: cTheme.Dimens.cardHeight,
                      child: TextField(
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          BlacklistingTextInputFormatter(
                              RegExp('[^A-z 0-9\s\d][\\\^]*'))
                        ],
                        onChanged: (newValue) =>
                            providerProjet.moduleNom = newValue,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: isEditing
                              ? providerProjet.moduleNom
                              : 'Nom du module...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                      header: LabelledIcon(
                        icon: Icon(
                          Icons.text_fields,
                          color: cTheme.MaderaColors.textHeaderColor,
                        ),
                        text: Text(
                          'Nom du module',
                          style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MaderaCard(
                          cardHeight: cTheme.Dimens.cardHeight,
                          cardWidth: 280.0,
                          header: LabelledIcon(
                            icon: Icon(Icons.straighten),
                            text: Text('Section (en centimètres)'),
                          ),
                          child: TextField(
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              BlacklistingTextInputFormatter(
                                RegExp('[^0-9]'),
                              ),
                              //WhitelistingTextInputFormatter(r'[0-9]*',),
                            ],
                            onTap: !isEditing
                                ? () => _formScrollController.jumpTo(
                                    _formScrollController
                                        .position.maxScrollExtent)
                                : null,
                            enabled: true,
                            onChanged: (newValue) =>
                                providerProjet.moduleSection = newValue,
                            decoration: InputDecoration(
                              hintText: isEditing
                                  ? providerProjet.moduleSection
                                  : 'Section...',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0),
                              )),
                            ),
                          ),
                        ),
                        MaderaCard(
                          cardHeight: cTheme.Dimens.cardHeight,
                          cardWidth: 280.0,
                          header: LabelledIcon(
                            icon: Icon(Icons.signal_cellular_null),
                            text: Text('Angle (Entrant ou Sortant)'),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValueAngle,
                              hint: !isEditing
                                  ? Text('Sélectionnez un type d\'angle...')
                                  : Text(providerProjet.moduleAngle.isNotEmpty
                                      ? providerProjet.moduleAngle
                                      : 'Sélectionnez un type d\'angle...'),
                              icon: Icon(Icons.arrow_drop_down,
                                  color: cTheme.MaderaColors.maderaLightGreen),
                              iconSize: 20,
                              elevation: 16,
                              style: TextStyle(
                                  color: cTheme.MaderaColors.textHeaderColor),
                              underline: Container(
                                color: Colors.transparent,
                              ),
                              items: ['Entrant', 'Sortant']
                                  .map<DropdownMenuItem<String>>(
                                      (String natureAngle) =>
                                          DropdownMenuItem<String>(
                                            value: natureAngle,
                                            child: Text(natureAngle),
                                          ))
                                  .toList(),
                              onChanged: (String newValue) {
                                providerProjet.moduleAngle = newValue;
                                setState(() => dropdownValueAngle = newValue);
                              },
                            ),
                          ),
                        ),
                        dropdownValueAngle != null ||
                                (isEditing &&
                                    (providerProjet.moduleAdd.produitModuleAngle
                                            .contains('Entrant') ||
                                        providerProjet
                                            .moduleAdd.produitModuleAngle
                                            .contains('Sortant')))
                            ? MaderaCard(
                                cardHeight: cTheme.Dimens.cardHeight,
                                cardWidth: 280.0,
                                header: LabelledIcon(
                                  icon: Icon(Icons.straighten),
                                  text: Text('Section (en centimètres)'),
                                ),
                                child: TextField(
                                  onChanged: (newValue) =>
                                      providerProjet.moduleSection2 = newValue,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    BlacklistingTextInputFormatter(
                                      RegExp('[^0-9]'),
                                    ),
                                    //WhitelistingTextInputFormatter(r'[0-9]*',),
                                  ],
                                  enabled: true,
                                  decoration: InputDecoration(
                                    hintText: isEditing
                                        ? providerProjet.moduleSection2
                                        : 'Section...',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0),
                                    )),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 500.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      stackAdditions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
              1200, MediaQuery.of(context).size.height / 6, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: providerProjet.isFilled('AddModule')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('AddModule')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  onPressed: providerProjet.isFilled('AddModule')
                      ? () {
                          log.d('Validating Module...');
                          providerProjet.updateModuleInfos();
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, Finishings(), null);
                        }
                      : null,
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: cTheme.MaderaColors.maderaLightGreen,
                    width: 2,
                  ),
                  color: cTheme.MaderaColors.maderaBlueGreen,
                ),
                child: IconButton(
                  onPressed: () {
                    log.d('Canceling Module...');
                    try {
                      providerProjet.deleteModuleFromProduct();
                      Provider.of<MaderaNav>(context)
                          .redirectToPage(context, ProductCreation(), null);
                    } catch (e) {
                      log.e('Error when trying to cancel module:\n$e');
                      if (e.runtimeType == RangeError)
                        Provider.of<MaderaNav>(
                                context) // Si c'est RangeError a priori c parce qu'on essai de supprimer un module qui n'existe pas dans la liste encore, alors on annule simplement et redirige vers productcreation
                            .redirectToPage(context, ProductCreation(), null);
                      else // Si c'est une autre erreur, le bouton ne fonctionnera pas
                        throw e;
                    }
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _createDropDowns(ProviderBdd providerBdd) {
    return Column(
      children: <Widget>[
        MaderaRoundedBox(
          boxHeight: cTheme.Dimens.boxHeight,
          boxWidth: 450.0,
          edgeInsetsPadding: EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('$dropdownValueNature'),
            icon: Icon(Icons.arrow_drop_down,
                color: cTheme.MaderaColors.maderaLightGreen),
            iconSize: 35,
            elevation: 16,
            style: Theme.of(context).textTheme.title.apply(fontSizeDelta: -4),
            underline: Container(
              height: 2,
              width: 100.0,
              color: Colors.transparent,
            ),
            onChanged: (String newValue) {
              providerBdd.initModules(
                  newValue); //Alimente le dropdown suivant avec une liste de modules préfaits de la nature $newValue
              setState(() {
                dropdownValueNature = newValue;
              });
            },
            items: providerBdd.listNatureModule != null
                ? providerBdd.listNatureModule
                    .map<DropdownMenuItem<String>>(
                        (String nature) => DropdownMenuItem<String>(
                              value: nature,
                              child: Text(nature),
                            ))
                    .toList()
                : null,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        MaderaRoundedBox(
          boxHeight: cTheme.Dimens.boxHeight,
          boxWidth: 450.0,
          edgeInsetsPadding: EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text('$dropdownValueModule'),
            icon: Icon(Icons.arrow_drop_down,
                color: cTheme.MaderaColors.maderaLightGreen),
            iconSize: 35,
            elevation: 16,
            style: Theme.of(context).textTheme.title.apply(fontSizeDelta: -4),
            underline: Container(
              height: 2,
              width: 100.0,
              color: Colors.transparent,
            ),
            //Charge les modules enregistrés en bdd
            items: providerBdd.listModule != null
                ? providerBdd.listModule
                    .map<DropdownMenuItem<String>>(
                        (ModuleData module) => DropdownMenuItem<String>(
                              value: module.nom,
                              child: Text(module.nom),
                            ))
                    .toList()
                : null,
            onChanged: (String newValue) {
              providerBdd.listModule.forEach((module) {
                if (module.nom == newValue) {
                  Provider.of<ProviderProjet>(context).moduleChoice = module;
                  Provider.of<ProviderProjet>(context).moduleNom = module.nom;
                }
              });
              setState(() {
                dropdownValueModule = newValue;
                Provider.of<ProviderProjet>(context).moduleNom =
                    newValue + '- ';
              });
            },
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
