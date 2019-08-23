import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/home/planetCard/PlanetCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanetsListWidget extends StatefulWidget {
  final List<Planet> _planets;

  PlanetsListWidget(this._planets);
  _PlanetsListWidgetState createState() => _PlanetsListWidgetState(_planets);
}

class _PlanetsListWidgetState extends State<PlanetsListWidget> {
  final List<Planet> _planets;

  _PlanetsListWidgetState(this._planets);
  int backgroundColor;
  Future<int> _getSavedAppBarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    backgroundColor = (prefs.getInt('background') ?? Colors.deepPurple.value);
    return (prefs.getInt('background') ?? Colors.deepPurple.value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSavedAppBarColors(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new Expanded(
                  flex: 1,
                  child: new Container(),
                );
              case ConnectionState.done:
              default:
                return new Expanded(
                  flex: 1,
                  child: new Container(
                    color: new Color(backgroundColor),
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          sliver: new SliverFixedExtentList(
                            itemExtent: 152.0,
                            delegate: new SliverChildBuilderDelegate(
                              (context, index) =>
                                  new PlanetCard(_planets[index]),
                              childCount: _planets.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          else
            return new Container();
        });
  }
}

class PlanetsList extends StatelessWidget {
  final List<Planet> _planets;

  PlanetsList(this._planets);
  int backgroundColor;
  Future<int> _getSavedAppBarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   
    backgroundColor = (prefs.getInt('background') ?? Colors.deepPurple.value);
    return (prefs.getInt('background') ?? Colors.deepPurple.value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSavedAppBarColors(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              case ConnectionState.none:
              case ConnectionState.waiting:
                return new Container();
              case ConnectionState.done:
              default:
                return new Expanded(
                  flex: 1,
                  child: new Container(
                    color: new Color(backgroundColor),
                    child: new CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: <Widget>[
                        new SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          sliver: new SliverFixedExtentList(
                            itemExtent: 152.0,
                            delegate: new SliverChildBuilderDelegate(
                              (context, index) =>
                                  new PlanetCard(_planets[index]),
                              childCount: _planets.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            }
          else
            return new Container();
        });
  }
}
