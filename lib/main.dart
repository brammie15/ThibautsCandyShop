import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thibaut_teller/addUserDialog.dart';
import 'package:thibaut_teller/devMenu.dart';
import 'package:thibaut_teller/klantDetailsAlert.dart';
import 'package:provider/provider.dart';
import 'package:thibaut_teller/optionsMenu.dart';
import 'package:thibaut_teller/providers/Klanten.dart';

import 'klant.dart';
import 'klantKader.dart';


class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int counter = 0;

  bool isSearching = false;

  String searchText = "";
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var klanten = context.watch<Klanten>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thibaut's Candy Shop"),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(onPressed: Provider.of<Klanten>(context, listen: false).getDataFromServer, icon: const Icon(Icons.download)),
          IconButton(onPressed: (){Provider.of<Klanten>(context, listen: false).saveInternaldataToServer(context);}, icon: const Icon(Icons.save)),
          IconButton(onPressed: Provider.of<Klanten>(context).getDataFromServer, icon: const Icon(Icons.refresh)),
          SizedBox(
            width: 40,
            child: InkWell(
              child: const Icon(Icons.settings),
              onTap: () {displaySettings(context);},
              onLongPress: () {displayDevMenu(context);},
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: Focus(
                focusNode: focusNode,
                autofocus: false,
                canRequestFocus: false,
                skipTraversal: true,
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      searchText = value;
                    });
                    if (value.isEmpty) {
                      setState(() {
                        isSearching = false;
                      });
                    } else {
                      setState(() {
                        isSearching = true;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Zoek',
                  ),
                ),
              ),
            ),
            Flexible(
              child: GridView.count(
                // physics: const ScrollPhysics(),
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                crossAxisCount: 4,
                children: getPeople(klanten),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => displayAddUserDialog(context),
          tooltip: 'Klant Toevoegen',
          child: const Icon(Icons.add)),
    );
  }

  Widget getKader(Klant klant) {
    return KlantKader(
        klantId: klant.id,
        onTap: () {
          focusNode.unfocus();
          handleTap(klant);
        });
  }

  List<Widget> getPeople(Klanten klanten) {
    if (isSearching) {
      List<Widget> klantList = klanten.klanten
          .where((klant) =>
              klant.name.toLowerCase().contains(searchText.toLowerCase()))
          .map((e) => getKader(e))
          .toList();
      return klantList;
    } else {
      return klanten.klanten.map((Klant klant) {
        return getKader(klant);
      }).toList();
    }
  }

  void handleTap(Klant klant) {
    klantenAlertDialog(context, klant.id);
  }

  void handleOption(String option) {
    switch (option) {
      case "dev":
        displayDevMenu(context);
        break;
    }
  }
}

class ThibautApp extends StatelessWidget {
  const ThibautApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Thibaut's Candy Shop",
      home: MainApp(),
    );
  }
}

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Klanten()),
      ],
      child: const ThibautApp(),
    ));
