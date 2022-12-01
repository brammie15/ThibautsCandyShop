import 'package:flutter/material.dart';
import 'package:thibaut_teller/providers/Klanten.dart';
import 'package:provider/provider.dart';

import 'klant.dart';

class KlantKader extends StatelessWidget {
  KlantKader({
    required this.klantId,
    required this.onTap,
    // required this.onTodoChanged,
  }) : super(key: ObjectKey(klantId));

  final String klantId;

  final VoidCallback onTap;
  // final onTodoChanged;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: InkWell(
        splashColor: Colors.pink,
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        onLongPress: () {
          print("Long Pressed");
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black45,
          ),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CircleAvatar(
                //   child: Text(Provider.of<Klanten>(context).getKlant(klantId).name[0]),
                //   maxRadius: 50,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      Provider.of<Klanten>(context).getKlant(klantId).name,
                      style: const TextStyle(fontSize: 34, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    Provider.of<Klanten>(context).getKlant(klantId).points.toString(),
                    style: const TextStyle(fontSize: 40, color: Colors.red),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: Optemize code abit but not that much, also fix loading of klanten, make it reshuffle after another klant is added ofc and make it so that it doesnt show the same klant twice in a row
