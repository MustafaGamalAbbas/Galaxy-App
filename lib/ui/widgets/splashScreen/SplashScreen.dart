import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/FetchingFromSharedPreference_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/ui/widgets/home/GradientAppBar.dart';
import 'package:galaxy/ui/widgets/home/HomeWidget.dart';

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
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        builder: (context) => FetchingSharedPreferenceBloc()..dispatch(BackGroundColor()),
        child: BlocBuilder<FetchingSharedPreferenceBloc, FetchingSharedPreferenceState>(
             builder: (context, state) {
              if (state is BackgroundSharedpreferenceState)
                return new Container(
                  decoration:
                      new BoxDecoration(color: new Color(state.background)),
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
                return new Container(width: 0.0, height: 0.0) ; 
            }),
      ),
    );
  }

  State<StatefulWidget> createState() {
    return new SplashScreen();
  }
}
