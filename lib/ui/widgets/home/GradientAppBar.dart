import 'package:flutter/material.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/planetsSearchWidget/CustomSearchDelegate.dart';
import 'package:galaxy/ui/widgets/settings/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;
  int rightCorner, leftCorner;
  GradientAppBar(this.title);

  Future<int> _getSavedAppBarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rightCorner = (prefs.getInt('rightCorner') ?? 0xFF3366FF);
    leftCorner = (prefs.getInt('leftCorner') ?? 0xFF00CCFF);
    return prefs.getInt('rightCorner') ?? 0xFF3366FF;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return FutureBuilder(
      future: _getSavedAppBarColors(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return new Container();
            case ConnectionState.done:
            default:
              return new Container(
                padding: new EdgeInsets.only(top: statusBarHeight),
                height: statusBarHeight + barHeight,
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      child: new Center(
                        child: new Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: 36.0),
                        ),
                      ),
                      decoration: new BoxDecoration(
                        gradient: new LinearGradient(
                            colors: [Color(leftCorner), Color(rightCorner)],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Align(
                          alignment: Alignment.centerRight,
                          child: new IconButton(
                              alignment: FractionalOffset.centerRight,
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 25.0,
                              ),
                              onPressed: () {
                                showSearch(
                                    context: context,
                                    delegate: CustomSearchDelegate(planets));
                              }),
                        ),
                        new IconButton(
                            alignment: FractionalOffset.centerRight,
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(new PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new Settings()));
                            }),
                      ],
                    ),
                  ],
                ),
              );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
