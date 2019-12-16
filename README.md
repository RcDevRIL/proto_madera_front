# proto_madera_front - README V1.2
__Build status by branch__
* __master :__ [![M_Codemagic build status][]][M_latest_build]
* __int :__ [![I_Codemagic build status][]][I_latest_build]
* __dev :__ [![D_Codemagic build status][]][D_latest_build]

* __Tests coverage :__ ![Coverage](https://github.com/RcDevRIL/proto_madera_front/blob/readMe/coverage/covbadge.svg)

Welcome on our development repository for our graduation project!! 

    You will find here the Flutter mobile application that we produce for our graduation 
    project during a 2-years work-study program with CESI Dijon school.
  
*Distributed by __LesCodeursEnBois__ - CESI RIL B2 - 2018-2020*

## Getting Started

This README will guide you through the setup and deployment of this application on a virtual device (or physical if you have one).

/!\ This README is a work in __progress__ ! /!\

###### Things to add on this README:

* [X] codemagic badges to show build/test status
* [X] Packages used to run the app
* [X] How to install/run app on device
* [X] How to run tests
* [ ] How to generate [moor_flutter] code
* [ ] How to ...

##### Prerequisites

What things you need to install and how to install them

* First you will need a copy of this repository: either use "Download" feature on [this][Github root] page, or use Git CLI if you have installed it on your computer:
    * `git clone https://github.com/RcDevRIL/proto_madera_front.git`

* Now you need to have the Flutter SDK to use CLI and run the app on device. Please refer to [Flutter "get started"] guide.


## Run app on device

If you went through all the steps on [flutter.dev][Flutter "get started"] you should have your favorite editor with plugins installed to connect to your device easily. 

To start build/install, execute this command:

* `flutter run`

This will install app on the connected device and run it. 

_If you have a real device, just plug it to the computer using your USB cable. The Flutter plugin should notice the device and will automatically add it on the list._

## Run tests

_This paragraph explain how to trigger tests written in the **[test]** folder of this repository._

To start tests, execute this command:

* `flutter test`

This will trigger the execution of tests. Depending on your IDE, you should see the results pretty easily. 

## Built With

* [Flutter] - The Dart framework used as my mobile app development main tool
* [provider] - The package used for handling state and logic of the app
* [rxdart] - The package used for handling streams
* [logger] - The package used for logging utilities
* [http] - The package used for making HTTP requests
* [crypto] - The package used to encrypt passwords
* [moor_flutter] - The package used to...
* [build_runner] - The package used under  "dev dependencies" to...

## Contributing

To contribute please email one of the authors...or hit that PR button!! :rocket: :smile:

## Authors

* **Romain** - *Main Author* - [RcDevRIL]
* **David** - *Main Author* - [BoiteSphinx]
* **Fabien** - *Main Author* - [LadouceFabien]

See also the list of [contributors] who participated in this project.

## License

This project is licensed under the GNU GENERAL PUBLIC LICENSE - see the [LICENSE.md] file for details

## Disclaimer

* As I mentionned before, this is still a work in progress. :upside_down_face:

[M_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da43b8a9f20ef13ab7a2016/status_badge.svg
[M_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da43b8a9f20ef13ab7a2016/latest_build
[I_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ac909f20ef30cdc3db79/status_badge.svg
[I_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ac909f20ef30cdc3db79/latest_build
[D_Codemagic build status]: https://api.codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ad409f20ef6c879feffc/status_badge.svg
[D_latest_build]: https://codemagic.io/apps/5da43b8a9f20ef13ab7a2017/5da5ad409f20ef6c879feffc/latest_build
[Flutter "get started"]: https://flutter.dev/get-started/
[Github root]: https://github.com/RcDevRIL/proto_madera_front/
[test]: https://github.com/RcDevRIL/proto_madera_front/tree/master/test
[Flutter]: https://github.com/flutter/flutter/
[provider]: https://pub.dev/packages/provider
[rxdart]: https://pub.dev/packages/rxdart
[logger]: https://pub.dev/packages/logger
[http]: https://pub.dev/packages/http
[crypto]: https://pub.dev/packages/crypto
[moor_flutter]: https://pub.dev/packages/moor_flutter
[build_runner]: https://pub.dev/packages/build_runner
[RcDevRIL]: https://github.com/RcDevRIL
[BoiteSphinx]: https://github.com/BoiteSphinx
[LadouceFabien]: https://github.com/LadouceFabien
[contributors]: https://github.com/RcDevRIL/proto_madera_front/contributors
[LICENSE.md]: https://github.com/RcDevRIL/proto_madera_front/blob/master/LICENSE
