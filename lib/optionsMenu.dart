import 'package:flutter/material.dart';
import 'package:thibaut_teller/dev/devButton.dart';
import 'package:provider/provider.dart';
import 'package:thibaut_teller/providers/Klanten.dart';

Future<void> displaySettings(BuildContext context) async {
  void closeDevMenu(){
    Navigator.of(context).pop();
  }
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        insetPadding: EdgeInsets.zero,
        title: const Text(
          "Settings",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            // mainAxisSize: MainAxisSize.values[0],
            mainAxisSize: MainAxisSize.values[0],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("er zijn nog nie echt instellingen")
            ],
          ),
        ),
      ));


}
