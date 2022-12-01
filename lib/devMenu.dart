import 'package:flutter/material.dart';
import 'package:thibaut_teller/dev/devButton.dart';
import 'package:provider/provider.dart';
import 'package:thibaut_teller/providers/Klanten.dart';

Future<void> displayDevMenu(BuildContext context) async {
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
              "Developer Menu",
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
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).getDataFromTemplateServer(); closeDevMenu();}, buttonText: "Get Data from template Server", buttonColor: Colors.greenAccent, textColorBlack: true),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).getDataFromServer(); closeDevMenu();}, buttonText: "Get Data from Server", buttonColor: Colors.amberAccent, textColorBlack: true),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).saveInternaldataToServer(context); closeDevMenu();}, buttonText: "Save Data to Server", buttonColor: Colors.black),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).clearKlanten(); closeDevMenu();}, buttonText: "Clear Internal Data", buttonColor: Colors.redAccent,),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).deleteDataFromDataServer(); closeDevMenu();}, buttonText: "Clear Server Data", buttonColor: Colors.red),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).initKlanten(); closeDevMenu();}, buttonText: "Copy Template Data To Server Storage", buttonColor: Colors.greenAccent),
                  devButton(onClick: () {Provider.of<Klanten>(context, listen: false).saveInternaldataToServer(context); closeDevMenu();}, buttonText: "Copy Internal Data to Server Storage"),
                ],
              ),
            ),
          ));


}
