import 'package:proto_madera_front/data/database/madera_database.dart';

class ProduitWithModule {
  final ProduitData produit;
  final List<ProduitModuleData> listProduitModule;

  ProduitWithModule(
    this.produit,
    this.listProduitModule,
  );

  Map<String, dynamic> toJson() => {
        'produit': produit,
        'listModules': listProduitModule,
      };
}
