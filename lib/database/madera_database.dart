import 'package:moor_flutter/moor_flutter.dart';
import 'package:proto_madera_front/database/tables.dart';

part 'madera_database.g.dart';

@UseMoor(tables: [
  Utilisateur,
  Composant,
  Gamme,
  Module,
  ModuleComposant,
  DevisEtat,
  Client,
  Adresse,
  ClientAdresse,
  Projet,
  ProjetModule
])
class MaderaDatabase extends _$MaderaDatabase {
  MaderaDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
            path: 'madera_db.sqlite',
          ),
        );
  //Si modification du schéma alors le schemaVersion prend +1
  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAllTables();
      }, onUpgrade: (Migrator m, int from, int to) async {
        //Actif que si le schemaVersion change
        //Suivant le schema de version met à jour la bdd
        if (from <= 2) {
          //Met à jour composant
          m.deleteTable('composant');
          m.createTable(composant);
        }
        if (from <= 4) {
          m.deleteTable('gamme');
          m.createTable(gamme);
        }
        if (from <= 5) {
          m.createTable(devisEtat);
        }
        if(from <= 6) {
          m.createTable(client);
          m.createTable(clientAdresse);
          m.createTable(adresse);
          m.createTable(projet);
          m.createTable(projetModule);
        }
      });
}
