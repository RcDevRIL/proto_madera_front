import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/composant.dart';

part 'composant_dao.g.dart';
@UseDao(tables: [Composant])
class ComposantDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantDaoMixin {
  ComposantDao(MaderaDatabase db) : super(db);

  String get querySelectComposantOfProjetSynchro => "SELECT composant.composant_id FROM composant "
      "LEFT JOIN module_composant ON module_composant.composant_id = composant.composant_id "
      "LEFT JOIN produit_module ON produit_module.module_id = module_composant.module_id "
      "LEFT JOIN projet_produits ON projet_produits.produit_id = produit_module.produit_id "
      "LEFT JOIN projet ON projet.projet_id = projet_produits.projet_id "
      "WHERE projet.is_synchro = 1 OR projet.projet_id IS NULL GROUP BY composant.composant_id";

  ///Supprime les occurences de composant
  Future<int> deleteAll() async {
    //Récupère la liste des composants qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listComposantId = await customSelectQuery(
            querySelectComposantOfProjetSynchro,
            readsFrom: {composant}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("composant_id"),
              )
              .toList(),
        );
    return await (delete(composant)
          ..where(
            (compo) => compo.composantId.isIn(listComposantId),
          ))
        .go();
  }

  ///Ajout d'une listComposant / utilisée lors de la méthode de synchro
  Future insertAll(List<ComposantData> listComposant) async {
    await db.batch((b) => b.insertAll(composant, listComposant));
  }
}
