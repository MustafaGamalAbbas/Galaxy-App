import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/home/PlanetList.dart';
import 'package:galaxy/ui/widgets/noInternetConnection/NoInternetConnection.dart';
import 'package:galaxy/utilities/ConnectionStatus.dart';

import 'GradientAppBar.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  _HomeWigetState createState() => _HomeWigetState();
}

class _HomeWigetState extends State<HomeWidget> {
  List<Planet> _planets = new List();
  ConnectionStatusSingleton connectionStatus;
  _HomeWigetState() {
    FirebaseDatabase.instance
        .reference()
        .child("galaxy")
        .child("planets")
        .onChildAdded
        .listen(_onEntryAdded);
  }
  @override
  void initState() {
    super.initState();
  }

  _onEntryAdded(Event event) {
    setState(() {
      Planet p = new Planet.fromSnapshot(event.snapshot);
      _planets.add(p);
      planets = _planets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder<bool>(
          future: connectionStatus.checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data)
              return Column(
                children: <Widget>[
                  GradientAppBar("Galaxy"),
                  PlanetsListWidget(_planets)
                ],
              );
            else {
              return NoInternetConnectionWidget();
            }
          }),
    );
  }
}
