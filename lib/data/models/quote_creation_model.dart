import 'package:flutter/material.dart';

class QuoteCreationModel {
  String dateDeCreation;
  String refProjet;
  Map<String, String> client;
  String descriptionProjet;

  QuoteCreationModel(
      {@required this.dateDeCreation,
      @required this.refProjet,
      @required this.client,
      @required this.descriptionProjet})
      : assert(refProjet != null && dateDeCreation != null);

  @override
  int get hashCode =>
      dateDeCreation.hashCode ^
      refProjet.hashCode ^
      descriptionProjet.hashCode ^
      client.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other is QuoteCreationModel &&
          refProjet == other.refProjet &&
          dateDeCreation == other.dateDeCreation &&
          descriptionProjet == other.descriptionProjet &&
          client == other.client;

  @override
  String toString() {
    StringBuffer sbuf = StringBuffer();
    sbuf.write('' 'dateDeCreation' ': ');
    sbuf.write(dateDeCreation);
    sbuf.write(',\n' 'refProjet' ': $refProjet,\n');
    sbuf.write('' 'client' ': {');
    client.forEach((key, value) => sbuf.write('$key : $value, '));
    sbuf.write('}\n');
    sbuf.write('' 'descriptionProjet' ': $descriptionProjet');
    return sbuf.toString();
  }
}
