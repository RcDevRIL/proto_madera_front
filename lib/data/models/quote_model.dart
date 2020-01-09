import 'package:flutter/material.dart';

class QuoteModel {
  String nomDeProduit;
  String gamme;
  Map<String, dynamic> listeModele;
  String modeleChoisi;
  Map<String, dynamic> listeModule;

  QuoteModel(
      {@required this.nomDeProduit,
      @required this.gamme,
      @required this.listeModele,
      @required this.modeleChoisi,
      @required this.listeModule})
      : assert(listeModele.length != 0);

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
  @override
  String toString() {
    StringBuffer sbuf = StringBuffer();
    sbuf.write('' 'nomDeProduit' ': $nomDeProduit,\n');
    sbuf.write('' 'gamme' ': $gamme,\n');
    sbuf.write('' 'listeModele' ': {');
    listeModele.forEach((key, value) => sbuf.write('$key : $value, '));
    sbuf.write('}\n');
    sbuf.write('' 'modeleChoisi' ': $modeleChoisi,\n');
    sbuf.write('' 'listeModule' ': {');
    listeModule.forEach((key, value) => sbuf.write('$key : $value, '));
    sbuf.write('}\n');
    return sbuf.toString();
  }
}
