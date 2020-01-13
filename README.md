# proto_madera_front - README V1.7.1
__Build status by branch__
* __master :__ [![M_Codemagic build status][]][M_latest_build]
* __int :__ [![I_Codemagic build status][]][I_latest_build]
* __dev :__ [![D_Codemagic build status][]][D_latest_build]

__Tests coverage :__
 ![Coverage](https://github.com/RcDevRIL/proto_madera_front/blob/master/coverage/covbadge.svg)

Welcome on our development repository for our graduation project!! 

    You will find here the Flutter mobile application that we produce for our graduation 
    project during a 2-years work-study program with CESI Dijon school.
  
*Distributed by __LesCodeursEnBois__ - CESI RIL B2 - 2018-2020*

## Documentation

To see the documentation of our app, please visit [our app documentation][doc_website].

## Getting Started

This README will guide you through the setup and deployment of this application on a virtual device (or physical if you have one).


##### Prerequisites

What things you need to install and how to install them

* First you will need a copy of this repository: either use "Download" feature on [this][Github root] page, or use Git CLI if you have installed it on your computer:
    * `git clone https://github.com/RcDevRIL/proto_madera_front.git`

* Now you need to have the Flutter SDK to use CLI and run the app on device. Please refer to [Flutter "get started"] guide.


If you went through all the steps on [flutter.dev][Flutter "get started"] you should have your favorite editor with plugins installed to connect to your device easily.

## Run app on device

Before wanting to launch the app, make sure to get the packages we chose to [build][Built_With] our app. To do so, you must run these commands:

* `flutter pub upgrade`
* `flutter pub get`

Among these packages, there is one that enables easy database interactions: [moor_flutter]. This package use the flutter code generator ([build_runner]) engine to reduce boilerplate for developers. So at this point, you should have 100+ errors on the opened git repository. You need to run the proper command to generate missing code:

`flutter packages pub run build_runner build`

__(if you want to navigate between commits you may have conflicting files. To fix this, add the following tag to the build command: `--delete-conflicting-outputs`)__

Now you can consider building and running the app :upside_down_face:

To start build-install-run process, execute this command:

`flutter run`

This will install the app on the connected device and run it. 

_If you have a real device, just plug it to the computer using your USB cable. The Flutter plugin should notice the device and will automatically add it on the list._

To start building the release .apk file, consider using this command:

`flutter build apk --split-per-abi`

This command will output several apks in the `/build/app/outputs/apk/release/` folder of your local repository. Choose the one that better fits your device architecture. 

__(We used the `app-x86_64-release.apk` to test our releases on the demonstration tablet)__

## Run Unit Tests

_This paragraph explain how to trigger tests written in the **[test]** folder of this repository._

To start unit tests, execute this command:

`flutter test`

This will trigger the execution of tests. Results will be printed on your console in the end.
You may also use your IDE integrated test report tool. Depending on the IDE, you should see the results pretty easily.

## Run Integration Tests

_This paragraph explain how to trigger tests written in the **[test_driver]** folder of this repository._

To start automated integration tests, make sure you have a connected Android device and execute this command:

`flutter drive --target=test_driver/madera_app.dart`

This will trigger the execution of the automated integration tests. It will launch the app on debug mode and execute implemented actions. This tool is great to enable stable integration of new releases :rocket:

But right now, the tests implemented are for demonstration purposes.

## Built With

_Direct Dependencies:_
* [Flutter] - The Google framework based on Dart used to build this app
* [provider] - The package used for handling state and logic of the app
* [rxdart] - The package used for handling streams
* [logger] - The package used for logging utilities
* [http] - The package used for making HTTP requests
* [crypto] - The package used to encrypt passwords
* [sqflite] - The package used to enable the creation and interactions on a "file-based" database ([SQLite] Flutter plugin)
* [moor_flutter] - The package used to ease database interaction (based on [sqflite])
* [json_serializable] - The packaged used to ease json (de)serialization
* [flutter_full_pdf_viewer] - The packaged used to display a pdf in-app
* [path_provider] - The packaged used to get application access to local device system file

_Development Dependencies:_
* [build_runner] - The package that let [moor_flutter] generate boilerplate code
* [moor_generator] - The packaged used with [build_runner]

_Test Dependencies:_
* [flutter_test] - The Flutter library used to implement unit tests
* [flutter_driver] - The Flutter library used to implement automated integration tests

## Contributing

To contribute please email one of the authors...or hit that PR button!! :rocket: :smile:

## Authors

* **Romain** - *Main Author* - [RcDevRIL]
* **David** - *Main Author* - [BoiteSphinx]
* **Fabien** - *Main Author* - [LadouceFabien]

See also the list of [contributors] who participated in this project.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE - see the [LICENSE.md] file for details


[M_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da43b8a9f20ef13ab7a2016/status_badge.svg
[M_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da43b8a9f20ef13ab7a2016/latest_build
[I_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5df94e11306e03621e0b7799/status_badge.svg
[I_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5df94e11306e03621e0b7799/latest_build
[D_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ad409f20ef6c879feffc/status_badge.svg
[D_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ad409f20ef6c879feffc/latest_build
[Flutter "get started"]: https://flutter.dev/get-started/
[Github root]: https://github.com/RcDevRIL/proto_madera_front/
[Built_With]: https://github.com/RcDevRIL/proto_madera_front/tree/master#built-with
[test]: https://github.com/RcDevRIL/proto_madera_front/tree/master/test
[test_driver]: https://github.com/RcDevRIL/proto_madera_front/tree/master/test_driver
[Flutter]: https://github.com/flutter/flutter/
[provider]: https://pub.dev/packages/provider
[rxdart]: https://pub.dev/packages/rxdart
[logger]: https://pub.dev/packages/logger
[http]: https://pub.dev/packages/http
[crypto]: https://pub.dev/packages/crypto
[sqflite]: https://pub.dev/packages/sqflite
[moor_flutter]: https://pub.dev/packages/moor_flutter
[moor_generator]: https://pub.dev/packages/moor_generator
[build_runner]: https://pub.dev/packages/build_runner
[json_serializable]: https://pub.dev/packages/json_serializable
[flutter_full_pdf_viewer]: https://pub.dev/packages/flutter_full_pdf_viewer
[path_provider]: https://pub.dev/packages/path_provider
[flutter_test]: https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html
[flutter_driver]: https://api.flutter.dev/flutter/flutter_driver/flutter_driver-library.html
[RcDevRIL]: https://github.com/RcDevRIL
[BoiteSphinx]: https://github.com/BoiteSphinx
[LadouceFabien]: https://github.com/LadouceFabien
[contributors]: https://github.com/RcDevRIL/proto_madera_front/contributors
[LICENSE.md]: https://github.com/RcDevRIL/proto_madera_front/blob/master/LICENSE
[SQLite]: https://www.sqlite.org
[doc_website]: http://vps756227.ovh.net/
