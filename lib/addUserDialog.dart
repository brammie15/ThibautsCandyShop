import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thibaut_teller/klant.dart';
import 'package:thibaut_teller/providers/Klanten.dart';

Future<void> displayAddUserDialog(BuildContext context) async {
  final TextEditingController naamController = TextEditingController();
  final TextEditingController puntenController = TextEditingController();
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
          style: TextStyle(fontSize: 40),
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
                controller: naamController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Naam',
                ),
              ),
              TextField(
                controller: puntenController,
                keyboardType: TextInputType.number,
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
                      if(naamController.text.isNotEmpty){
                        int aantalPunten = 0;
                        if(puntenController.text.isEmpty){
                          aantalPunten = 0;
                        }else{
                          aantalPunten = int.parse(puntenController.text);
                        }
                        Provider.of<Klanten>(context, listen: false).addKlant(Klant(name: naamController.text, punten: aantalPunten, aantalRecieved: 0));
                        naamController.clear();
                        puntenController.clear();
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