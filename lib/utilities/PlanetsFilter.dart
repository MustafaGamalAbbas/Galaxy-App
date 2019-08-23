import 'package:galaxy/models/Planet.dart';

class PlanetsFilter {
  List<Planet> _planets;

  PlanetsFilter(this._planets);

  List<Planet> filter(query) {
    List<Planet> planets = new List();
    for (var i = 0; i < this._planets.length; i++) {
      if (this
          ._planets[i]
          .name
          .toLowerCase()
          .contains(query.toString().toLowerCase())) {
        planets.add(this._planets[i]);
      }
    }
    return planets;
  }
}
