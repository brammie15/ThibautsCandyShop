import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thibaut_teller/klantDetailsAlert.dart';
import 'package:provider/provider.dart';
import 'package:thibaut_teller/providers/Klanten.dart';

import 'klant.dart';
import 'klantKader.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _naamController = TextEditingController();
  final TextEditingController _puntenController = TextEditingController();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thibaut's Candy Shop"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: GridView.count(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          crossAxisCount: 2,
          children: context.read<Klanten>().klanten.map((Klant klant) {
            return KlantKader(
              klantId: klant.id,
              onTap: () {
                handleTap(klant);
              },
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Klant Toevoegen',
          child: const Icon(Icons.add)),
    );
  }

  void handleTap(Klant klant) {
    klantenAlertDialog(context, klant.id);
  }

  // void _handleAddPunt(Klant klant, int punten){
  //   context.read<Klanten>().handleAddPunt(klant, punten);
  // }
  //
  // void _handleSubtractPunt(Klant klant, int punten){
  //   context.read<Klanten>().handleSubtractPunt(klant, punten);
  // }

  void _addKlant(String name, int punten) {
    // punten = (punten == null) ? 0 : punten;
    context
        .read<Klanten>()
        .addKlant(Klant(name: name, punten: punten, aantalItems: 0));
    _naamController.clear();
    _puntenController.clear();
  }

  Future<void> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              insetPadding: EdgeInsets.zero,
              title: const Text(
                "Klant Toevoegen",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 40),
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.values[0],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _naamController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Naam',
                      ),
                    ),
                    TextField(
                      controller: _puntenController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Punten',
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if(_naamController.text.isNotEmpty){
                              _addKlant(_naamController.text, _puntenController.text != "" ? int.parse(_puntenController.text) : 0);
                              print("Naam: ${_naamController.text} Punten: ${_puntenController.text}");
                              Navigator.of(context).pop();
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Vul alle velden in'),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Toevoegen"),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text("Annuleren"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}

class ThibautApp extends StatelessWidget {
  const ThibautApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Thibaut's Candy Shop",
      home: TodoList(),
    );
  }
}

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Klanten()),
      ],
      child: ThibautApp(),
    ));
