import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:galaxy/ui/widgets/home/GradientAppBar.dart';
import 'package:galaxy/ui/widgets/home/HomeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SplashScreen();
  }
}

class SplashScreen extends State<StatefulWidget> {
  final databaseReference = FirebaseDatabase.instance.reference();
  int backgroundColorValue;
  SplashScreen();
  
  _pushMember(BuildContext context) {
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => new HomeWidget()));
  }

  void getData(BuildContext context) {
     databaseReference.once().then((DataSnapshot snapshot) {
      _pushMember(context);
    });
  }

  @override
  void initState() {
    super.initState();
    getData(context);
  }

  Future<int> _getBackgroundColor() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    backgroundColorValue = preferences.getInt("background") ?? Colors.purple;
    return preferences.getInt("background") ?? Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Object>(
          future: _getBackgroundColor(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return new Container(
                decoration:
                    new BoxDecoration(color: new Color(backgroundColorValue)),
                child: new Stack(
                  children: <Widget>[
                    GradientAppBar("Galaxy"),
                    Center(
                        child: new CircularProgressIndicator(
                      backgroundColor: (Colors.cyan),
                    )),
                  ],
                ),
              );
            else
              return new Container();
          }),
    );
  }

  State<StatefulWidget> createState() {
    return new SplashScreen();
  }
}
