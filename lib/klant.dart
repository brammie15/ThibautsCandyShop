import 'dart:core';
import 'dart:convert';

import 'package:uuid/uuid.dart';

class Klant {
  String id = "";
  String name = "";
  int points = 0; //aantal aankopen gedaan
  int toRecieveFreeCandy = 0;
  int amountRecievedFreeCandy = 0; //aantal ontvangen gratis snoepjes

  Klant(
      {required this.name,
      required punten,
      required this.amountRecievedFreeCandy}) {
    this.points = (punten > 0) ? punten : 0;
    this.toRecieveFreeCandy =
        (this.points / 10).floor() - this.amountRecievedFreeCandy;
    this.id = const Uuid().v4();
  }

  void addPunt(int punten) {
    this.points += punten;
    this.toRecieveFreeCandy =
        (this.points / 10).floor() - amountRecievedFreeCandy;
  }

  void subtractPunt(int punten) {
    this.points -= punten;
    toRecieveFreeCandy = (this.points / 10).floor() - amountRecievedFreeCandy;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toString(),
      'points': points,
      'toRecieveFreeCandy': toRecieveFreeCandy,
      'saldo': ""
    };
  }

  factory Klant.fromJson(dynamic json) {
    print("Trying to read this data " + json.toString());
    String name = json['name'];
    name = name[0].toUpperCase() + name.substring(1);
    int points = json['points'] as int;
    int toRecieveFreeCandy = json['toRecieveFreeCandy'];
    // double saldo = json['saldo'] as double;
    int amountRecievedFreeCandy = (points / 10).floor() - toRecieveFreeCandy;

    return Klant(
        name: name,
        punten: points,
        amountRecievedFreeCandy: amountRecievedFreeCandy
    );
  }
}
