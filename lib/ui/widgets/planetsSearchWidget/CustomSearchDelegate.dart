import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/home/PlanetList.dart';
import 'package:galaxy/utilities/PlanetsFilter.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Planet> planets;
  PlanetsFilter _filter;

  CustomSearchDelegate(this.planets) {
    _filter = new PlanetsFilter(this.planets);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          close(context, null);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
     return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
 
    return new Flex(
      direction: Axis.vertical,
      children: <Widget>[new PlanetsList(_filter.filter(query))],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
 
    return new Flex(
      direction: Axis.vertical,
      children: <Widget>[new PlanetsList(_filter.filter(query))],
    );
  }
}
