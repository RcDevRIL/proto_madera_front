import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/models/produit_with_module.dart';

///
/// Model used to store a [ProjetData] with a [List] of [ProduitWithModule]
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
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
