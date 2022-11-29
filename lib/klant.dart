import 'dart:core';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Klant {
  Klant({required this.name, required punten, required this.aantalRecieved}){
    print(punten);
    this.punten = (punten > 0) ? punten : 0;
    this.freecandy = (this.punten / 10).floor() - aantalRecieved;
    this.id = const Uuid().v4();
  }

  void addPunt(int punten){
    this.punten += punten;
    this.freecandy = (this.punten / 10).floor() - aantalRecieved;
  }

  void subtractPunt(int punten){
    this.punten -= punten;
    freecandy = (this.punten / 10).floor() - aantalRecieved;
  }

  factory Klant.fromJson(dynamic json) {
    int aantalItemsEx = json['aantalspeciaal'] as int;
    int puntenEx = json['punten'] as int;
    aantalItemsEx = (puntenEx / 10).floor() - aantalItemsEx;
    String naam = json['naam'] ?? 'Geen naam';
    naam = naam[0].toUpperCase() + naam.substring(1);

    return Klant(name: json['name'] as String, punten: puntenEx, aantalRecieved: json['aantalItems'] ?? 0 as int);
  }

  String id = "";
  String name = "";
  int punten = 0; //aantal aankopen gedaan
  int freecandy = 0;
  int aantalRecieved = 0; //aantal ontvangen gratis snoepjes
}