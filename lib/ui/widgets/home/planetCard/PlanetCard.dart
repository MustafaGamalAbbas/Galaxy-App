import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/detailPlanet/DetailWidget.dart';
import 'package:galaxy/ui/widgets/home/planetCard/PlanetCardContent.dart';
class PlanetCard extends StatelessWidget {
  final Planet planet;

  PlanetCard(this.planet);

  Container getPlanetThumbnail(image) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new Hero(
        tag: "planet-hero-${planet.id}",
        child: new Image(
          image: new AssetImage(planet.image),
          
        ),
      ),
    );
    return planetThumbnail;
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DetailWidget(planet),
          )),
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            new Container(
              child: PlanetCardContent.getPlanetCardContent(planet),
              height: 124.0,
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
            ),
            getPlanetThumbnail(planet.image),
          ],
        ),
      ),
    );
  }
}
