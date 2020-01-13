import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:proto_madera_front/data/database/madera_database.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';

///
/// Point d'entrée de notre suite de tests unitaires.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 1.0-PRE-RELEASE
void main() {
  final ProviderBdd providerBdd = ProviderBdd();

  group('General Unit Tests', () {
    testWidgets(
      'init ProviderNavigation on HomePage test',
      (WidgetTester tester) async {
        Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => MaderaNav()),
              ChangeNotifierProvider(create: (context) => providerBdd),
            ],
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        // Build our app and trigger a frame.
        await tester.pumpWidget(testWidget);
        expect(find.text("default"),
            findsWidgets); // Comme on a directement lancé la page d'accueil,
        // pas d'appel à redirectToPage -> pas d'appel à l'update des properties de navigation -> valeurs à default
      },
    );
    test(
      'init providerProjet test',
      () {
        ProviderProjet providerProjet = ProviderProjet();
        providerProjet.initAndHold();
        expect(providerProjet.projetNom, '');
        ClientData testClient = ClientData(
          id: 4,
          mail: 'test@user.com',
          nom: 'testuser',
          numTel: '00000000',
          prenom: 'test',
        );
        expect(providerProjet.initProjet(), false); //false car pas de client
        providerProjet
            .initClientWithClient(testClient); //ajout d'un client de test
        expect(providerProjet.initProjet(), true);

        providerProjet.initProductCreationModel();
        expect(providerProjet.produitModules.length,
            0); // 0 car initialisation de la liste des produits

        expect(providerProjet.produitNom.isEmpty, true); // Nom produit vide
        providerProjet.produitNom = "Maison modulaire standard";
        expect(providerProjet.produitNom.isNotEmpty,
            true); // Nom produit mis à jour

        expect(providerProjet.initListProduitModuleProjet(null), false);
        List<ProduitModuleData> listProduitModule = [
          ProduitModuleData(
            projetModuleId: 1,
            moduleId: 1,
            produitModuleNom: "Mur standard 1",
            produitModuleAngle: "Angle Sortant",
            produitModuleSectionLongueur: "{\"section\": {\"longueur\": 350}}",
          )
        ];
        expect(providerProjet.initListProduitModuleProjet(listProduitModule),
            true);

        providerProjet.initModuleInfos();
        expect(providerProjet.moduleNom.isEmpty, true);
        GammeData gamme = GammeData(gammeId: 1, libelleGammes: "Standard");
        providerProjet.gamme = gamme;
        providerProjet.initProduitWithModule();
        providerProjet.updateListProduitProjet();
        expect(providerProjet.listProduitProjet.length > 0, true);

        expect(providerProjet.projetWithAllInfos == null, true);
        providerProjet.initProjetWithAllInfos();
        expect(providerProjet.projetWithAllInfos != null, true);

        providerProjet.initAndHold();
        expect(providerProjet.gamme, gamme);

        providerProjet.validate(true);
        providerProjet.initAndHold();
        expect(providerProjet.gamme, null);

        expect(providerProjet.isFilled(''), false);
        expect(providerProjet.isFilled('QuoteCreation'), false);

        providerProjet.initClientWithClient(testClient);
        providerProjet.initProjet();
        providerProjet.produitNom = "Maison modulaire standard";
        providerProjet.gamme = gamme;
        providerProjet.initListProduitModuleProjet(listProduitModule);
        expect(providerProjet.isFilled('ProductCreation'), true);
      },
    );
    test(
      'Update route state',
      () async {
        final MaderaNav providerNavigation =
            MaderaNav(); // initialisation du provider
        int index = providerNavigation.pageIndex;
        String title = providerNavigation.pageTitle;
        expect(index, -1); // variable si null renvoie -1
        expect(title, 'default'); // variable si null renvoie 'default'
        providerNavigation.updateCurrent(
            AuthenticationPage); // change les propriétés de navigation
        index = providerNavigation.pageIndex;
        title = providerNavigation.pageTitle;
        expect(-1, index);
        expect("Bienvenue sur l'application métier MADERA !", title);
        providerNavigation
            .updateCurrent(HomePage); // test d'une autre page existante
        index = providerNavigation.pageIndex;
        title = providerNavigation.pageTitle;
        expect(0, index);
        expect("Page d'accueil", title);
        providerNavigation.updateCurrent(
            ChangeNotifier); // test avec un mauvais type d'argument -> error et set les propriétés aux valeurs par défaut
        index = providerNavigation.pageIndex;
        title = providerNavigation.pageTitle;
        expect(-1, index);
        expect('default', title);
      },
    );
    test('last sync date test', () {
      final ProviderSynchro providerSynchro = ProviderSynchro(
        db: ProviderBdd.db,
        daosSynchroList: providerBdd.daosSynchroList,
      );
      var date = DateTime.now();

      expect(date.isAfter(providerSynchro.refsLastSyncDate),
          true); // la synchronisation n'a pas eu lieue
    });
    test(
      'ping test',
      () async {
        final ProviderLogin providerLogin = ProviderLogin(db: ProviderBdd.db)
          ..http = MockClient((request) async {
            return Response('', 200);
          });
        expect(providerLogin.ping(), completion(true));
      },
    );
    test(
      'connection test',
      () async {
        final ProviderLogin providerLogin = ProviderLogin(db: ProviderBdd.db)
          ..http = MockClient((request) async {
            //On set le contenu du body et le statusCode attendu, dans notre cas le token de connection
            return Response(
                jsonEncode({
                  'utilisateurId': 4,
                  'login': 'testuser',
                  'token': 'fesfk-feksnf-fesf'
                }),
                200);
          });
        //On execute le test, qui va alors servir du body que l'on a renseigné pour générer une response conformes aux besoins
        expect(
            providerLogin.connection('testuser', '123456'), completion(true));
      },
    );
    testWidgets('logout test', (tester) async {
      final ProviderLogin providerLogin = ProviderLogin(db: ProviderBdd.db)
        ..http = MockClient((request) async {
          return Response('', 200);
        });

      expect(providerLogin.logout(), completion(true));
    });
    test('synchro globale test', () async {
      final ProviderSynchro providerSynchro = ProviderSynchro(
        db: ProviderBdd.db,
        daosSynchroList: providerBdd.daosSynchroList,
      )..http = MockClient((request) async {
          //On set le contenu du body et le statusCode attendu, dans notre cas le token de connection
          return Response('', 200);
        });
      DateTime now = DateTime.now();
      await providerSynchro.synchro();
      expect(providerSynchro.refsLastSyncDate.isAfter(now), true);
      expect(providerSynchro.dataLastSyncDate.isAfter(now), true);
      await providerSynchro
          .synchro(); // checker les logs (expect: 'Synchronisations déjà effectuées!') éventuellement utiliser package test_process pour tester la valeurs des logs?
      expect(providerSynchro.refsLastSyncDate.isAfter(now), true);
      expect(providerSynchro.dataLastSyncDate.isAfter(now), true);
    });
  });
}
