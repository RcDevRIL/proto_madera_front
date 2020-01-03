///
/// Class to store api urls
///
/// @authors HELIOT David, CHEVALLIER Romain, LADOUCE Fabien
///
/// @version 0.4-RELEASE
class MaderaUrl {
  const MaderaUrl();

  static const String baseUrl = 'https://cesi-madera.fr/api';
  // String baseUrl = 'http://10.0.2.2:8081/api';

  static const String urlAuthentification = baseUrl + '/authentification';
  static const String urlDeconnection = baseUrl + '/deconnection';
  static const String urlSynchroRef = baseUrl + '/referentiel';
  static const String urlSynchroData = baseUrl + '/synchro';
}
