import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables.dart';

part 'database_dao.g.dart';

/*Classe relative à la base de données*/
@UseDao(tables: [
  Utilisateur,
  Adresse,
  ClientAdresse,
  Client,
  Composant,
  ComposantGroupe,
  DevisEtat,
  Gamme,
  ModuleComposant,
  Module,
  Produit,
  ProduitModule,
  Projet,
  ProjetProduits
])
class DatabaseDao extends DatabaseAccessor<MaderaDatabase>
    with _$DatabaseDaoMixin {
  DatabaseDao(MaderaDatabase db) : super(db);

  ///Méthode suppresion bdd
  void drop() async {
    await delete(utilisateur).go();
    await delete(adresse).go();
    await delete(clientAdresse).go();
    await delete(client).go();
    await delete(composant).go();
    await delete(composantGroupe).go();
    await delete(devisEtat).go();
    await delete(gamme).go();
    await delete(moduleComposant).go();
    await delete(module).go();
    await delete(produit).go();
    await delete(produitModule).go();
    await delete(projet).go();
    await delete(projetProduits).go();
  }
}
