import 'package:flutter/material.dart';

class QuoteCreationModel {
  DateTime dateDeCreation;
  String refProjet;
  Map<String, dynamic> client;
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
}
