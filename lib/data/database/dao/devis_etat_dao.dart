import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/devis_etat.dart';

part 'devis_etat_dao.g.dart';

@UseDao(tables: [DevisEtat])
class DevisEtatDao extends DatabaseAccessor<MaderaDatabase>
    with _$DevisEtatDaoMixin {
  DevisEtatDao(MaderaDatabase db) : super(db);

  Future insertAll(List<DevisEtatData> listDevisEtat) async {
    await delete(devisEtat).go();
    await db.batch((b) => b.insertAll(devisEtat, listDevisEtat));
  }

  /// Méthode utilisée pour récupérer les données dans la table devisEtat
  /// Renvoie une [List<[DevisEtatData]>] des états de devis enregistrés dans les référentiels
  Future<List<DevisEtatData>> getDevisEtatData() async {
    return select(devisEtat).get();
  }
}
