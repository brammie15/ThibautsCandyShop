import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thibaut_teller/util/readJson.dart';

import '../klant.dart';

class Klanten with ChangeNotifier {
  List<Klant> _klanten = <Klant>[];

  List<Klant> get klanten => _klanten;

  void addKlant(Klant klant) {
    Klant nieuweKlant = klant;
    nieuweKlant.name = klant.name[0].toUpperCase() + klant.name.substring(1);
    print(
        "new Klant added, Naam: ${nieuweKlant.name} Punten: ${nieuweKlant.points}");

    _klanten.add(nieuweKlant);
    // notifyListeners();
    _klanten.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void removeKlant(Klant klant) {
    _klanten.remove(klant);
    notifyListeners();
  }

  void addPunten(String id, int punten) {
    Klant klant = getKlant(id);
    klant.points += punten;
    klant.toRecieveFreeCandy =
        (klant.points / 10).floor() - klant.amountRecievedFreeCandy;
    notifyListeners();
  }

  void subtractPunten(String id, int punten) {
    Klant klant = getKlant(id);
    klant.points -= punten;
    klant.toRecieveFreeCandy =
        (klant.points / 10).floor() - klant.amountRecievedFreeCandy;
    notifyListeners();
  }

  void handleAddItem(Klant klant, int aantalItems) {
    klant.amountRecievedFreeCandy += aantalItems;
    klant.toRecieveFreeCandy =
        (klant.points / 10).floor() - klant.amountRecievedFreeCandy;
    notifyListeners();
  }

  void handleSubtractItem(Klant klant, int aantalItems) {
    klant.amountRecievedFreeCandy -= aantalItems;
    klant.toRecieveFreeCandy =
        (klant.points / 10).floor() - klant.amountRecievedFreeCandy;
    notifyListeners();
  }

  void handleReset(Klant klant) {
    klant.points = 0;
    klant.amountRecievedFreeCandy = 0;
    klant.toRecieveFreeCandy = 0;
    notifyListeners();
  }

  void clearKlanten() async {
    _klanten.clear();
    // deleteFile(await getFile("data.json"));
    notifyListeners();
  }

  void handleDelete(Klant klant) {
    removeKlant(klant);
  }

  void handleEdit(Klant klant, String naam) {
    klant.name = naam;
    notifyListeners();
  }

  Klant getKlant(String id) {
    return _klanten.firstWhere((Klant klant) => klant.id == id);
  }

  void recieveSpecial(String id) {
    Klant klant = getKlant(id);
    klant.amountRecievedFreeCandy += 1;
    notifyListeners();
  }

  void getDataFromTemplateServer() async {
    List<dynamic> templateList = await readJson();
    _klanten = templateList.map((dynamic item) => Klant.fromJson(item)).toList();
    _klanten.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void deleteDataFromDataServer() async {
    File file = await getFile("data.json");
    deleteFile(file);
  }

  void getDataFromServer() async {
    //TODO: Add actual networking
    // List<dynamic> templateList = await readJson();
    File file = await getFile('data.json');
    // String contents = await readFile(file) as String;
    String fileContent = await readFile(file);
    // writeContent(fileContent, file);
    print(fileContent);

    List<dynamic> templateList = jsonDecode(fileContent);
    _klanten = templateList.map((dynamic item) => Klant.fromJson(item)).toList();


    // List<dynamic> jsonData = await json.decode(fileContent);

    // _klanten = jsonData.map((dynamic item) => Klant.fromJson(item)).toList();
    // //sort alphabetically
    _klanten.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void saveInternaldataToServer(BuildContext context) async {
    File file = await getFile('data.json');
    print(await file.readAsString());
    print(jsonEncode(_klanten));
    writeContent(jsonEncode(_klanten), file);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Data saved to server"),
    ));
  }

  void initKlanten() async {
    List<dynamic> templateList = await readJson();
    File file = await getFile('data.json');

    String data = jsonEncode(templateList);
    print(data);
    writeContent(json.encode(templateList), file);
    print("Klanten Initted");
  } 
}
