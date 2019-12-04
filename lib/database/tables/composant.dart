
import 'package:moor_flutter/moor_flutter.dart';

class Composant extends Table {
  IntColumn get composantId => integer()();
  //TODO composantGroupe . Stocker que l'id + le libelle?
  TextColumn get libelle => text()();
  //TODO Composantrefentiel ?
  //TODO Attention doit être en double ou float
  TextColumn get section => text()();
  
}