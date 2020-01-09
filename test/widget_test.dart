import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

import 'package:proto_madera_front/data/providers/providers.dart';
import 'package:proto_madera_front/ui/pages/pages.dart';

///
/// Point d'entrée de notre suite de tests unitaires.
///
/// @author HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
void main() {
  final ProviderBdd providerBdd = ProviderBdd();

  group('General Unit Tests', () {
    testWidgets(
      'init ProviderNavigation on HomePage test',
      (WidgetTester tester) async {
        final MaderaNav providerNavigation = MaderaNav();
        Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => providerNavigation),
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
        //TODO
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
    testWidgets(
      'ping test',
      (WidgetTester tester) async {
        final ProviderLogin providerLogin = ProviderLogin(db: ProviderBdd.db)
          ..http = MockClient((request) async {
            return Response('', 200);
          });
        final MaderaNav providerNavigation = MaderaNav();

        Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => providerLogin),
              ChangeNotifierProvider(create: (context) => providerNavigation),
            ],
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        await tester.pumpWidget(testWidget);
        expect(providerLogin.ping(), completion(true));
      },
    );
    testWidgets(
      'connection test',
      (tester) async {
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
        final MaderaNav providerNavigation = MaderaNav();

        Widget testWidget = MediaQuery(
          data: MediaQueryData(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => providerLogin),
              ChangeNotifierProvider(create: (context) => providerNavigation),
            ],
            child: MaterialApp(
              home: HomePage(),
            ),
          ),
        );
        await tester.pumpWidget(testWidget);
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
      final MaderaNav providerNavigation = MaderaNav();

      Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => providerLogin),
            ChangeNotifierProvider(create: (context) => providerNavigation),
          ],
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );
      await tester.pumpWidget(testWidget);

      expect(providerLogin.logout(), completion(true));
    });
    testWidgets('synchro globale test', (tester) async {
      final MaderaNav providerNavigation = MaderaNav();
      final ProviderSynchro providerSynchro = ProviderSynchro(
        db: ProviderBdd.db,
        daosSynchroList: providerBdd.daosSynchroList,
      )..http = MockClient((request) async {
          //On set le contenu du body et le statusCode attendu, dans notre cas le token de connection
          return Response('', 200);
        });

      Widget testWidget = MediaQuery(
        data: MediaQueryData(),
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => providerSynchro),
            ChangeNotifierProvider(create: (context) => providerNavigation),
          ],
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );
      await tester.pumpWidget(testWidget);
      DateTime now = DateTime.now();
      await providerSynchro.synchro();
      expect(providerSynchro.refsLastSyncDate.isBefore(now),
          true); //isBefore parce qu'on compare a now() (yyyy-MM-dd HH:mm:SS), alors que les dates sont stockées sous la forme 'yyyy-MM-dd 00:00:00'

      expect(providerSynchro.dataLastSyncDate.isBefore(now), true);
      await providerSynchro
          .synchro(); // checker les logs (expect: 'Synchronisations déjà effectuées!') éventuellement utiliser package test_process pour tester la valeurs des logs?
      expect(providerSynchro.refsLastSyncDate.isBefore(now), true);
      expect(providerSynchro.dataLastSyncDate.isBefore(now), true);
    });
  });
}
