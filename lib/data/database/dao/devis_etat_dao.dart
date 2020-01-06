import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/devis_etat.dart';

part 'devis_etat_dao.g.dart';

@UseDao(tables: [DevisEtat])
class DevisEtatDao extends DatabaseAccessor<MaderaDatabase>
    with _$DevisEtatDaoMixin {
  DevisEtatDao(MaderaDatabase db) : super(db);

  String get queryDevisEtatIdOfProjetIsSynchro =>
      "SELECT * FROM devis_etat JOIN projet ON projet.devis_etat_id = devis_etat.devis_etat_id WHERE projet.is_synchro = 1";

  Future insertAll(List<DevisEtatData> listDevisEtat) async {
    await db.batch((b) => b.insertAll(devisEtat, listDevisEtat));
  }

  /// Méthode utilisée pour récupérer les données dans la table devisEtat
  /// Renvoie une [List<[DevisEtatData]>] des états de devis enregistrés dans les référentiels
  Future<List<DevisEtatData>> getDevisEtatData() async {
    return select(devisEtat).get();
  }

  Future<int> deleteAll() async {
    //Récupère la liste des gammeId qui doivent être supprimés (en fonction de is_synchro de projet)
    List<int> listDevisEtatId = await customSelectQuery(
            queryDevisEtatIdOfProjetIsSynchro,
            readsFrom: {devisEtat}).get().then(
          (rows) => rows
              .map<int>(
                (row) => row.readInt("devis_etat_id"),
              )
              .toList(),
        );
    return await (delete(devisEtat)
          ..where(
            (de) => de.devisEtatId.isIn(listDevisEtatId),
          ))
        .go();
  }
}
