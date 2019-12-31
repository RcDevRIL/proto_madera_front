import 'package:flutter/material.dart';

class QuoteModel {
  String nomDeProduit;
  String gamme;
  List<String> listeModele;
  String modeleChoisi;
  Map<String, dynamic> listeModule;

  QuoteModel(
      {@required this.nomDeProduit,
      @required this.gamme,
      this.listeModele,
      @required this.modeleChoisi,
      @required this.listeModule})
      : assert(listeModule.length != 0);

  @override
  int get hashCode =>
      gamme.hashCode ^
      nomDeProduit.hashCode ^
      modeleChoisi.hashCode ^
      listeModule.hashCode ^
      listeModele.hashCode;

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      other is QuoteModel &&
          nomDeProduit == other.nomDeProduit &&
          gamme == other.gamme &&
          modeleChoisi == other.modeleChoisi &&
          listeModule == other.listeModule &&
          listeModele == other.listeModele;
}
