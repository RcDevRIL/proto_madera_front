
import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/madera_database.dart';
import 'package:proto_madera_front/database/tables/devis_etat.dart';

part 'devis_etat_dao.g.dart';

@UseDao(tables: [DevisEtat])
class DevisEtatDao extends DatabaseAccessor<MaderaDatabase> with _$DevisEtatDaoMixin {
  DevisEtatDao(MaderaDatabase db) : super(db);

  Future insertAll(List<DevisEtatData> listDevisEtat) async {
    await delete(devisEtat).go();
    await into(devisEtat).insertAll(listDevisEtat);
  }
}