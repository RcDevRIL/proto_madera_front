import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/providers/provider_bdd.dart';
import 'package:proto_madera_front/data/providers/providers.dart'
    show MaderaNav, ProviderProjet;
import 'package:proto_madera_front/theme.dart' as cTheme;
import 'package:proto_madera_front/ui/pages/pages.dart'
    show AddModule, ProductList;
import 'package:proto_madera_front/ui/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';

///
/// Product creation page
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.5-RELEASE
class ProductCreation extends StatefulWidget {
  static const routeName = '/quote';

  @override
  _ProductCreationState createState() => _ProductCreationState();
}

class _ProductCreationState extends State<ProductCreation> {
  final log = Logger();
  bool isEditing;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context).settings.arguments;
    var providerProjet = Provider.of<ProviderProjet>(context);
    var providerBdd = Provider.of<ProviderBdd>(context);
    (providerProjet.editProductIndex ==
                providerProjet.listProduitProjet.length) ||
            (providerProjet.listProduitProjet.length == 0)
        ? isEditing = false
        : isEditing = true;
    return MaderaScaffold(
      passedContext: context,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              isEditing
                  ? 'Edition du Produit n°${providerProjet.editProductIndex + 1}'
                  : 'Création d\'un nouveau produit',
              style:
                  cTheme.MaderaTextStyles.appBarTitle.copyWith(fontSize: 32.0),
            ),
            GradientFrame(
              child: Column(
                children: <Widget>[
                  MaderaCard(
                    cardWidth: MediaQuery.of(context).size.width / 2,
                    cardHeight: 40.0,
                    child: TextField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        BlacklistingTextInputFormatter(
                            RegExp('[^A-z 0-9\s\d][\\\^]*'))
                      ],
                      enabled: true,
                      onChanged: (String newValue) {
                        providerProjet.produitNom = newValue;
                      },
                      decoration: InputDecoration(
                        //TODO style dynamique : style hint si pas de produit, style defaulttextstyle si produit nom renseigné
                        hintText: !isEditing
                            ? 'Nom du produit...'
                            : providerProjet.produitNom,
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
                        'Nom du produit',
                        style: cTheme.MaderaTextStyles.appBarTitle.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxHeight: 55,
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    edgeInsetsMargin: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: providerProjet.gamme == null
                          ? Text('Sélectionnez une gamme...')
                          : Text(providerProjet.gamme.libelleGammes),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      items: providerBdd.listGammes
                          .map<DropdownMenuItem<String>>(
                              (GammeData gamme) => DropdownMenuItem<String>(
                                    value: gamme.libelleGammes,
                                    child: Text(gamme.libelleGammes),
                                  ))
                          .toList(),
                      onChanged: (String newValue) {
                        providerBdd.listGammes.forEach(
                          (gamme) async => {
                            if (gamme.libelleGammes == newValue)
                              {
                                //Enregistre la nouvelle gamme
                                providerProjet.gamme =
                                    gamme, //TODO par contre depuis quand c'est des ',' pour finir une ligne? :o
                                //Initialise la liste des modeles avec la gamme
                                await providerBdd
                                    .initListProduitModele(gamme.gammeId),
                                //Supprime les modules du modèle précédent qui sont encore listés en bas de l'interface
                                providerProjet.resetListProduitModuleProjet(
                                    providerBdd.listProduitModule),
                              }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaRoundedBox(
                    boxWidth: MediaQuery.of(context).size.width / 2,
                    boxHeight: cTheme.Dimens.boxHeight,
                    edgeInsetsPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: providerProjet.modelProduit == null
                          ? Text('Sélectionnez un modèle de produit...')
                          : Text(providerProjet.modelProduit.produitNom),
                      icon: Icon(Icons.arrow_drop_down,
                          color: cTheme.MaderaColors.maderaLightGreen),
                      iconSize: 20,
                      elevation: 16,
                      style:
                          TextStyle(color: cTheme.MaderaColors.textHeaderColor),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      items: providerBdd.listProduitModele != null
                          ? providerBdd.listProduitModele
                              .map<DropdownMenuItem<String>>(
                                (ProduitData produit) =>
                                    DropdownMenuItem<String>(
                                  value: produit.produitNom,
                                  child: Text(produit.produitNom),
                                ),
                              )
                              .toList()
                          : null,
                      onChanged: providerProjet.gamme != null
                          ? (String newValue) {
                              providerBdd.listProduitModele.forEach(
                                (produit) async => {
                                  if (produit.produitNom == newValue)
                                    {
                                      providerProjet.modelProduit = produit,
                                      //Charge les produitModules
                                      await providerBdd.initListProduitModule(
                                        produit.produitId,
                                      ),
                                      providerProjet
                                          .initListProduitModuleProjet(
                                        providerBdd.listProduitModule,
                                      ),
                                    }
                                },
                              );
                            }
                          : null,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  MaderaCard(
                    cardHeight: MediaQuery.of(context).size.height / 3.2,
                    child: Stack(
                      children: <Widget>[
                        providerProjet.produitModules.length != 0
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: providerProjet.produitModules.length,
                                itemBuilder: (c, i) => Material(
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor:
                                        cTheme.MaderaColors.maderaBlueGreen,
                                    child: ListTile(
                                      title: Text(
                                        providerProjet.produitModules
                                            .elementAt(i)
                                            .produitModuleNom,
                                      ),
                                    ),
                                    onTap: () {
                                      log.d('Modifying module...');
                                      providerProjet.editModuleIndex = i;
                                      providerProjet.loadModuleInfos(i);
                                      Provider.of<MaderaNav>(context)
                                          .redirectToPage(
                                              context, AddModule(), null);
                                    },
                                  ),
                                ),
                                separatorBuilder: (c, i) => Divider(
                                  color: Colors.green,
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: MaderaButton(
                            onPressed: providerProjet.gamme != null
                                ? () {
                                    log.d('Adding Module for this quote');
                                    providerProjet.editModuleIndex =
                                        providerProjet.produitModules
                                            .length; //on veut indexmax+1
                                    providerProjet.initModuleInfos();
                                    Provider.of<MaderaNav>(context)
                                        .redirectToPage(
                                            context, AddModule(), null);
                                  }
                                : null,
                            child: LabelledIcon(
                              icon: Icon(Icons.add),
                              text: Text('Ajouter Module'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    header: LabelledIcon(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: cTheme.MaderaColors.textHeaderColor,
                      ),
                      text: Text('Liste des Modules'),
                    ),
                  ),
                ],
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
                      color: providerProjet.isFilled('ProductCreation')
                          ? cTheme.MaderaColors.maderaLightGreen
                          : Colors.grey,
                      width: 2),
                  color: providerProjet.isFilled('ProductCreation')
                      ? cTheme.MaderaColors.maderaBlueGreen
                      : Colors.grey,
                ),
                child: IconButton(
                  tooltip: 'Valider produit',
                  onPressed: providerProjet.isFilled('ProductCreation')
                      ? () {
                          log.d('Saving form...');
                          providerProjet.initProduitWithModule();
                          providerProjet.updateListProduitProjet();
                          providerProjet.logQ();
                          log.d('Done.');
                          Provider.of<MaderaNav>(context)
                              .redirectToPage(context, ProductList(), null);
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
                        color: cTheme.MaderaColors.maderaLightGreen, width: 2),
                    color: cTheme.MaderaColors.maderaBlueGreen),
                child: IconButton(
                  tooltip: 'Supprimer produit',
                  onPressed: () {
                    Provider.of<MaderaNav>(context).showPopup(
                        context,
                        Icons.warning,
                        'Remise à zéro',
                        Center(
                            child: Text(
                                'Voulez-vous vraiment remettre ce formulaire à zéro?')),
                        [
                          MaderaButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Annuler'),
                          ),
                          MaderaButton(
                            onPressed: () {
                              Provider.of<ProviderProjet>(context)
                                  .initProductCreationModel(); //TODO Corriger, le nom reste si remplit avant clic, pourtant modele bien vide
                              Navigator.of(context).pop();
                            },
                            child: Text('Oui'),
                          ),
                        ]);
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
}
