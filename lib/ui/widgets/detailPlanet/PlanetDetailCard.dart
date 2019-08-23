import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/customWidgets/Separator.dart';

class PlanetDetailCard extends StatelessWidget {
  final Planet planet;
  final bool horizontal;

  PlanetDetailCard(this.planet, {this.horizontal = true});

  PlanetDetailCard.vertical(this.planet) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.only(top: 16.0, bottom: 0.0),
      alignment: FractionalOffset.center,
      child: new Hero(
        tag: "planet-hero-${planet.id}",
        child: new Image(
          image: new AssetImage(planet.image),
          height: 100,
          width: 100,
        ),
      ),
    );

    Widget _planetValue({String value, String image}) {
      return Padding(
        padding: const EdgeInsets.only(top: 8),
        child: new Container(
          child: new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 16.0),
            new Text(value, style: Style.smallTextStyle.copyWith(fontSize: 10)),
          ]),
        ),
      );
    }

    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(planet.name, style: Style.titleTextStyle),
          new Container(height: 4.0),
          new Text(planet.location, style: Style.commonTextStyle),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                  flex: 0,
                  child: _planetValue(
                      value: planet.distance,
                      image: 'assets/images/ic_distance.png')),
              new Container(
                width: 32.0,
              ),
              new Expanded(
                  flex: 0,
                  child: _planetValue(
                      value: planet.gravity,
                      image: 'assets/images/ic_gravity.png'))
            ],
          ),
        ],
      ),
    );

    final planetCard = new Container(
      child: planetCardContent,
      height: 160.0,
      margin: new EdgeInsets.only(top: 72.0),
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

    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          planetCard,
          planetThumbnail,
        ],
      ),
    );
  }
}
