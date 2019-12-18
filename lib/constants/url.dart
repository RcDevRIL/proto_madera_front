///
/// Class permettant de stocker nos URLS
///
/// @authors HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.3-PRERELEASE
class MaderaUrl {
  const MaderaUrl();

  static const String baseUrl = 'https://cesi-madera.fr/madera';
  // String baseUrl = 'http://10.0.2.2:8081/madera';

  static const String urlAuthentification = baseUrl + '/authentification';
  static const String urlDeconnection = baseUrl + '/deconnection';
  static const String urlSynchroRef = baseUrl + '/referentiel';
  static const String urlSynchroData = baseUrl + '/synchro';
}
