// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:proto_madera_front/providers/provider_login.dart';
import 'package:proto_madera_front/ui/pages/widgets/my_widgets.dart';

void main() {
  group('Tests', () {
    testWidgets('first test', (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new AppBarMadera()));
      // Build our app and trigger a frame.
      await tester.pumpWidget(testWidget);
      // Simplest test, useless for now, just to make build pass on codemagic.
      expect(find.text("HOME PAGE"), findsOneWidget);
    });

    test('connection test', (WidgetTester tester) async {
      // Lancer le back-end
      ProviderLogin providerLogin = new ProviderLogin();
      await providerLogin
          .ping()
          .then((value) => expect(true, value));
    });
  });
}
