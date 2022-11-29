import 'dart:core';

import 'package:uuid/uuid.dart';

class Klant {
  Klant({required this.name, required this.punten, required this.aantalItems}){
    punten = (punten != null) ? 0 : punten;
    freecandy = (this.punten / 10).floor() - aantalItems;
    id = Uuid().v4();
  }

  void addPunt(int punten){
    this.punten += punten;
    freecandy = (this.punten / 10).floor() - aantalItems;
  }

  void subtractPunt(int punten){
    this.punten -= punten;
    freecandy = (this.punten / 10).floor() - aantalItems;
  }
  String id = "";
  String name = "";
  int punten = 0; //aantal aankopen gedaan
  int freecandy = 0;
  int aantalItems = 0; //aantal ontvangen gratis snoepjes
}