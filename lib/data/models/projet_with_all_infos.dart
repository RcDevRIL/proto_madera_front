import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/produit_with_module.dart';

class ProjetWithAllInfos {
  final ProjetData projet;
  final List<ProduitWithModule> listProduitWithModule;

  ProjetWithAllInfos(
    this.projet,
    this.listProduitWithModule,
  );

  Map<String, dynamic> toJson() => {
        'projet': projet,
        'produitWithModule': listProduitWithModule,
        //TODO changer
        'listUtilisateurId': [
          4,
        ]
      };
}
