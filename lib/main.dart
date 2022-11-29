import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thibaut_teller/addUserDialog.dart';
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
  int counter = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Thibaut's Candy Shop"),
        backgroundColor: Colors.pink,
        actions: [
          PopupMenuButton<String>(
            onSelected: handleOption,
            itemBuilder: (BuildContext context) {
              return {'GetData', 'Clear'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        leading: const Icon(
          Icons.menu,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Zoek',
                ),
              ),
            ),
            Container(
              // width: MediaQuery.of(context).size.width,
              child: Flexible(
                child: GridView.count(
                  // physics: const ScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  // shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  crossAxisCount: 4,
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

  void handleTap(Klant klant) {
    klantenAlertDialog(context, klant.id);
  }

  void handleOption(String option){
    print(option);
    switch(option){
      case "GetData":
        Provider.of<Klanten>(context, listen: false).pullFromServer();
        break;
      case "Clear":
        Provider.of<Klanten>(context, listen: false).clearKlanten();
        break;
    }
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
