import 'package:flutter_driver/driver_extension.dart';
import 'package:proto_madera_front/main.dart' as app;

void main() {
  enableFlutterDriverExtension(); // Enable the extension
  app.main(); // Call the `main()` function of the app.
}
