import 'package:flutter/material.dart';

import '../klant.dart';

class Klanten with ChangeNotifier{
  List<Klant> _klanten = <Klant>[];

  List<Klant> get klanten => _klanten;

  void addKlant(Klant klant){
    klant.name = klant.name[0].toUpperCase() + klant.name.substring(1);
    _klanten.add(klant);
    notifyListeners();
  }

  void removeKlant(Klant klant){
    _klanten.remove(klant);
    notifyListeners();
  }

  void addPunten(String id, int punten){
    Klant klant = getKlant(id);
    klant.punten += punten;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalItems;
    notifyListeners();
  }

  void subtractPunten(String id, int punten){
    Klant klant = getKlant(id);
    klant.punten -= punten;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalItems;
    notifyListeners();
  }

  void handleAddItem(Klant klant, int aantalItems){
    klant.aantalItems += aantalItems;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalItems;
    notifyListeners();
  }

  void handleSubtractItem(Klant klant, int aantalItems){
    klant.aantalItems -= aantalItems;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalItems;
    notifyListeners();
  }

  void handleReset(Klant klant){
    klant.punten = 0;
    klant.aantalItems = 0;
    klant.freecandy = 0;
    notifyListeners();
  }

  void handleDelete(Klant klant){
    removeKlant(klant);
  }

  void handleEdit(Klant klant, String naam){
    klant.name = naam;
    notifyListeners();
  }

  Klant getKlant(String id){
    return _klanten.firstWhere((Klant klant) => klant.id == id);
  }

  void recieveSpecial(String id){
    Klant klant = getKlant(id);
    klant.aantalItems += 1;
    notifyListeners();
  }

}