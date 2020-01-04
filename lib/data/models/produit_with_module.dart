import 'package:proto_madera_front/data/database/madera_database.dart';

class ProduitWithModule {
  final ProduitCompanion produit;
  final List<ProduitModuleCompanion> listProduitModule;

  ProduitWithModule(
    this.produit,
    this.listProduitModule,
  );
}
