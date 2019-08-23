import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/styles/Text_Style.dart';

class PlanetCardContent extends StatelessWidget {
  final Planet planet;

  PlanetCardContent(this.planet);

  static Container getPlanetCardContent(planet) {
    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(height: 1.0),
          new Text(
            planet.name,
            style: Style.headerTextStyle,
          ),
          new Container(height: 1.0),
          new Text(planet.location, style: Style.subHeaderTextStyle),
          new Container(
              margin: new EdgeInsets.symmetric(vertical: 7.0),
              height: 2.0,
              width: 20.0,
              color: new Color(0xff00c6ff)),
          new Row(
            children: <Widget>[
              new Expanded(
                child: new Row(children: <Widget>[
                  new Image.asset("assets/images/ic_distance.png",
                      height: 12.0),
                  new Container(width: 8.0),
                  new Text(planet.distance, style: Style.regularTextStyle.copyWith(fontSize: 10)),
                ]),
              ),
              new Expanded(
                child: new Row(children: <Widget>[
                  new Image.asset("assets/images/ic_gravity.png", height: 12.0),
                  new Container(width: 8.0),
                  new Text(planet.gravity, style: Style.regularTextStyle.copyWith(fontSize: 10)),
                ]),
              )
            ],
          ),
        ],
      ),
    );
    return planetCardContent;
  }

  @override
  Widget build(BuildContext context) {
     final planetCard = new Container(
      height: 145.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
    return new Stack(
      children: <Widget>[planetCard, getPlanetCardContent(planet)],
    );
  }
}
