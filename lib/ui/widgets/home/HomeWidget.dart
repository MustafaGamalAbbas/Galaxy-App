import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/internetConnection/bloc.dart';
import 'package:galaxy/ui/widgets/home/PlanetList.dart';
import 'package:galaxy/ui/widgets/noInternetConnection/NoInternetConnection.dart';
import 'package:galaxy/utilities/ConnectionStatus.dart';

import 'GradientAppBar.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);

  _HomeWigetState createState() => _HomeWigetState();
}

class _HomeWigetState extends State<HomeWidget> {
  ConnectionStatusSingleton connectionStatus;
  _HomeWigetState();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: BlocProvider(
          builder: (context) => InternetconnectionBloc(),
          child: BlocBuilder<InternetconnectionBloc, InternetconnectionState>(
              builder: (context, status) {
            if (status is Connected)
              return Column(
                children: <Widget>[
                  GradientAppBar("Galaxy"),
                  PlanetsListWidget()
                ],
              );
            else {
              return NoInternetConnectionWidget();
            }
          })),
    );
  }
}
