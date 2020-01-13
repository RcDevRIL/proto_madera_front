import 'package:proto_madera_front/data/database/madera_database.dart';

///
/// Model used to store a [ProduitData] with a [List] of [ProduitModuleData]
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-RELEASE
class ProduitWithModule {
  final ProduitData produit;
  final List<ProduitModuleData> listProduitModule;

  ProduitWithModule(
    this.produit,
    this.listProduitModule,
  );

  @override
  String toString() {
    var sb = StringBuffer();
    sb.write(produit.toString());
    sb.write('\n');
    listProduitModule.forEach((p) => sb.write(p.toString()));
    return sb.toString();
  }

  Map<String, dynamic> toJson() => {
        'produit': produit,
        'listModules': listProduitModule,
      };
}
