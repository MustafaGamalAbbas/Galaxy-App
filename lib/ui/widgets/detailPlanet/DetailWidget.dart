import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/customWidgets/Separator.dart';
import 'package:galaxy/ui/dialogs/YoutubePlayerDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PlanetDetailCard.dart';

class DetailWidget extends StatefulWidget {
  final Planet planet;

  DetailWidget(this.planet);

  @override
  State<StatefulWidget> createState() {
    return new DetailScreen(planet);
  }
}

class DetailScreen extends State<StatefulWidget> {
  final Planet planet;

  DetailScreen(this.planet);
  Container _getBackground() {
    return new Container(
      child: new Image.network(
        planet.picture,
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(backgroundColor - 0xFF000000),
            new Color(backgroundColor)
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Container _getContent() {
    final _overviewTitle = "Overview".toUpperCase();
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new PlanetDetailCard(planet),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            height: 50,
            child: RawMaterialButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => YoutubePlayerDialog(
                      youtubeVideoId: planet.youtubeVideoId),
                );
              },
              shape: StadiumBorder(),
              fillColor: new Color(0xFF333366),
              splashColor: new Color(0xFF3366FF),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.play_circle_filled,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Play a video",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new Text(
                    _overviewTitle,
                    style: Style.headerTextStyle,
                  ),
                ),
                new Separator(),
                new Text(planet.description, style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }

  int backgroundColor;
  Future<int> _getSavedAppBarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    backgroundColor = (prefs.getInt('background') ?? Colors.deepPurple.value);
    return (prefs.getInt('background') ?? Colors.deepPurple.value);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
          future: _getSavedAppBarColors(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return new Container(
                constraints: new BoxConstraints.expand(),
                color: new Color(backgroundColor),
                child: new Stack(
                  children: <Widget>[
                    _getBackground(),
                    _getGradient(),
                    _getContent(),
                    _getToolbar(context),
                  ],
                ),
              );
            else
              return Container();
          }),
    );
  }
}
