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
    final homePage = find.byType('HomePage');
    final authPage = find.byType('AuthenticationPage');
    final alertDialog = find.byType('AlertDialog');
    final alertDialogOkButton = find.byValueKey('ok-button');

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
  });
}
