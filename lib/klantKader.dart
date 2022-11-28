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
              color: Colors.black45),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CircleAvatar(
              //   child: Text(klant.name[0]),
              //   maxRadius: 50,
              // ),
              Text(
                Provider.of<Klanten>(context).getKlant(klantId).name,
                style: const TextStyle(fontSize: 34, color: Colors.white),
              ),
              Text("${Provider.of<Klanten>(context).getKlant(klantId).punten}", style: TextStyle(fontSize: 20, color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}
