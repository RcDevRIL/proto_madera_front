import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/produit_with_module.dart';

class ProjetWithAllInfos {
  final ProjetData projet;
  final List<ProduitWithModule> listProduitWithModule;

  ProjetWithAllInfos(
    this.projet,
    this.listProduitWithModule,
  );
  @override
  String toString() {
    var sb = StringBuffer();
    sb.write(projet.toString());
    sb.write('\n');
    listProduitWithModule.forEach((p) => sb.write(p.toString()));
    return sb.toString();
  }

  Map<String, dynamic> toJson() => {
        'projet': projet,
        'produitWithModule': listProduitWithModule,
        'listUtilisateurId': [
          4,
        ]
      };
}
