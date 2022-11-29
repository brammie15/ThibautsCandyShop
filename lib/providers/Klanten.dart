import 'package:flutter/material.dart';
import 'package:thibaut_teller/readJson.dart';

import '../klant.dart';

class Klanten with ChangeNotifier{
  List<Klant> _klanten = <Klant>[];

  List<Klant> get klanten => _klanten;


  void addKlant(Klant klant){
    Klant nieuweKlant = klant;
    nieuweKlant.name = klant.name[0].toUpperCase() + klant.name.substring(1);
    print("new Klant added, Naam: ${nieuweKlant.name} Punten: ${nieuweKlant.punten}");

    _klanten.add(nieuweKlant);
    notifyListeners();
  }

  void removeKlant(Klant klant){
    _klanten.remove(klant);
    notifyListeners();
  }

  void addPunten(String id, int punten){
    Klant klant = getKlant(id);
    klant.punten += punten;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalRecieved;
    notifyListeners();
  }

  void subtractPunten(String id, int punten){
    Klant klant = getKlant(id);
    klant.punten -= punten;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalRecieved;
    notifyListeners();
  }

  void handleAddItem(Klant klant, int aantalItems){
    klant.aantalRecieved += aantalItems;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalRecieved;
    notifyListeners();
  }

  void handleSubtractItem(Klant klant, int aantalItems){
    klant.aantalRecieved -= aantalItems;
    klant.freecandy = (klant.punten / 10).floor() - klant.aantalRecieved;
    notifyListeners();
  }

  void handleReset(Klant klant){
    klant.punten = 0;
    klant.aantalRecieved = 0;
    klant.freecandy = 0;
    notifyListeners();
  }
  void clearKlanten(){
    _klanten.clear();
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
    klant.aantalRecieved += 1;
    notifyListeners();
  }

  void pullFromServer() async { //TODO: Add actual networking
    List<dynamic> json = await readJson();
    _klanten = json.map((dynamic item) => Klant.fromJson(item)).toList();
    //sort alphabetically
    _klanten.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

}