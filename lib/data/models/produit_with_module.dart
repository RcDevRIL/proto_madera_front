import 'package:proto_madera_front/database/madera_database.dart';
    //TODO il va avoir des problèmes sur le final de la variable ainsi que plein de required dans la construction !

class ProduitWithModule {
  final ProduitData produit;
  final List<ProduitModuleData> listProduitModule;

  ProduitWithModule(
    this.produit,
    this.listProduitModule,
  );
}
