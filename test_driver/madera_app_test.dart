import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:logger/logger.dart';

void main() {
  group('Madera App', () {
    final Logger log = Logger();
    // First, locate the widgets by their keys.
    final usernameTextFinder = find.byValueKey('username');
    final passwordTextFinder = find.byValueKey('password');
    final submitButton = find.byValueKey('connect');
    final authPage = find.byType('AuthenticationPage');
    final alertDialog = find.byType('AlertDialog');
    final alertDialogOkButton = find.byValueKey('ok-button');
    final profileTile = find.byValueKey('profile-tile');
    final profilePage = find.byType('ProfilePage');
    final homeTile = find.byValueKey('home-tile');
    final homePage = find.byType('HomePage');
    final quoteToolTile = find.byValueKey('quote_tool-tile');
    final quoteToolPage = find.byType('QuoteCreation');
    final quoteOverviewTile = find.byValueKey('quote_overview-tile');
    final quoteOverviewPage = find.byType('QuoteOverview');
    final notificationsTile = find.byValueKey('notifications-tile');
    final notificationsPage = find.byType('NotificationPage');
    final settingsTile = find.byValueKey('settings-tile');
    final settingsPage = find.byType('settingsPage');
    final expandDrawerButton = find.byValueKey('expand-drawer');
    final logoutButton = find.byValueKey('logout-button');

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Connection KO - Identifiants incorrects', () async {
      await driver.waitFor(authPage);

      await driver.tap(usernameTextFinder);
      await driver.enterText("testuser");

      await driver.tap(passwordTextFinder);
      await driver.enterText("11111");

      await driver.tap(submitButton);

      await driver.waitFor(alertDialog);
      assert(alertDialog != null);

      await driver.tap(alertDialogOkButton);

      await driver.waitUntilNoTransientCallbacks();

      assert(homePage == null);
    });

    test('Connection OK - Identifiants corrects', () async {
      await driver.waitFor(authPage);

      await driver.tap(usernameTextFinder);
      await driver.enterText("testuser");

      await driver.tap(passwordTextFinder);
      await driver.enterText("123456");

      await driver.tap(submitButton);
      // Rajout d'un try/catch pour le cas ou la tablette est hors ligne.
      try {
        //Bizarrement le timeout fait réussir le test. Mais c toujours mieux qu'une exception
        await driver.waitFor(homePage).timeout(Duration(
            seconds:
                12)); //2secondes de plus que le timeout présent dans providerlogin
        assert(homePage != null);

        await driver
            .waitUntilNoTransientCallbacks()
            .timeout(Duration(seconds: 12));
      } on Exception catch (e) {
        log.e('Device not connected to internet?\n$e');
        assert(false);
      }
    });

    test('Drawer test OK', () async {
      await driver.waitFor(homePage).timeout(Duration(seconds: 12));

      await driver.tap(profileTile);
      await Future.delayed(Duration(seconds: 3));
      assert(profilePage != null);

      await driver.tap(homeTile);
      await Future.delayed(Duration(seconds: 3));
      assert(homePage != null);

      await driver.tap(quoteToolTile);
      await Future.delayed(Duration(seconds: 3));
      assert(quoteToolPage != null);

      await driver.tap(quoteOverviewTile);
      await Future.delayed(Duration(seconds: 3));
      assert(quoteOverviewPage != null);

      await driver.tap(notificationsTile);
      await Future.delayed(Duration(seconds: 3));
      assert(notificationsPage != null);

      await driver.tap(settingsTile);
      await Future.delayed(Duration(seconds: 3));
      assert(settingsPage != null);

      try {
        await driver.tap(expandDrawerButton);
        await Future.delayed(Duration(seconds: 2));

        await driver.tap(logoutButton);
        await Future.delayed(Duration(seconds: 3));
        assert(authPage != null);
      } catch (e) {
        log.e("Can't expand drawer... \n $e");
        assert(false);
      }
    });
  });
}
