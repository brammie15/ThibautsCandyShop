import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:thibaut_teller/providers/Klanten.dart';
import 'package:thibaut_teller/puntenButton.dart';
import 'package:provider/provider.dart';


import 'klant.dart';

Future<void> klantenAlertDialog(
    BuildContext context,
    String klantId,
) async {
  return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            insetPadding: EdgeInsets.zero,
            title: Center(
                child: Text("${Provider.of<Klanten>(context).getKlant(klantId)}", style: const TextStyle(fontSize: 40))),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisSize: MainAxisSize.values[0],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Punten", style: TextStyle(fontSize: 35)),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("${Provider.of<Klanten>(context).getKlant(klantId).punten}",
                          style: const TextStyle(fontSize: 70, color: Colors.pink)),
                      const Divider(),
                      Text("Aantal items: ${Provider.of<Klanten>(context).getKlant(klantId).freecandy}",
                          style: const TextStyle(fontSize: 20)),
                      Column(
                        children: [
                          puntenButton(
                            onClick: () {
                              Provider.of<Klanten>(context, listen: false).addPunten(klantId, 1);
                            },
                            buttonText: "+1",
                            buttonColor: Colors.green,
                            width: 200,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          puntenButton(
                            onClick: () {
                              Provider.of<Klanten>(context, listen: false).subtractPunten(klantId, 1);
                            },
                            buttonText: "Verwijder punt",
                            buttonColor: Colors.red,
                            width: 150,
                            height: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          puntenButton(
                            onClick: (){
                              Provider.of<Klanten>(context, listen: false).recieveSpecial(klantId);
                              Provider.of<Klanten>(context, listen: false).subtractPunten(klantId, 0); //doing this so it will reRender
                            },
                            buttonText: "redeem Speciaal",
                            active: Provider.of<Klanten>(context).getKlant(klantId).aantalItems >= 1,
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: 200,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Sluit',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
  );
}
