import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:proto_madera_front/data/database/tables/composant_groupe.dart';

part 'composant_groupe_dao.g.dart';

@UseDao(tables: [ComposantGroupe])
class ComposantGroupeDao extends DatabaseAccessor<MaderaDatabase>
    with _$ComposantGroupeDaoMixin {
  ComposantGroupeDao(MaderaDatabase db) : super(db);

  ///Ajout d'une list de composantGroupe / utilisée lors de la méthode de synchro
  Future insertAll(List<ComposantGroupeData> listComposantGroupe) async {
    deleteAll();
    await db.batch((b) => b.insertAll(composantGroupe, listComposantGroupe));
  }

  ///Supprime les occurrences de composantGroupe
  Future<int> deleteAll() async {
    return await delete(composantGroupe).go();
  }
}
