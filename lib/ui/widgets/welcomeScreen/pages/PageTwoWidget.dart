import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class _PageTwoViewState extends State<PageTwoView>
    with TickerProviderStateMixin {
  double _padding = 16;
  final String imageURL;
  double _width = 0;
  _PageTwoViewState(this.imageURL);
  AnimationController milkyController, galaxyController, livingController;
  Animation<double> milkyAnimation, galaxyAnimation, livingAnimation;

  initState() {
    super.initState();

    milkyController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    galaxyController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    livingController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    milkyAnimation =
        CurvedAnimation(parent: milkyController, curve: Curves.easeInBack);
    galaxyAnimation =
        CurvedAnimation(parent: galaxyController, curve: Curves.easeInBack);
    livingAnimation = Tween(begin: 10.0, end: 100.0).animate(
        CurvedAnimation(parent: livingController, curve: Curves.easeIn));

    livingAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        milkyController.forward();
      } else if (status == AnimationStatus.dismissed) {}
    });
    milkyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        galaxyController.forward();
      } else if (status == AnimationStatus.dismissed) {}
    });
    livingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      if (mounted)
        setState(() {
          _width = 150;
          _padding = 8;
        });
    });
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(seconds: 2),
          padding: _padding == 16 ? EdgeInsets.all(32) : EdgeInsets.all(8),
          color: Colors.black,
          curve: Curves.easeIn,
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageURL),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(16),
              )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 144),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AnimatedBuilder(
                  animation: livingAnimation,
                  builder: (BuildContext context, Widget child) {
                    return new Text(
                      "Milky Way ",
                      style: TextStyle(
                          fontSize: 52,
                          color: new Color(0xff00c6ff),
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    width: _width,
                    duration: Duration(seconds: 1),
                    curve: Curves.decelerate,
                    child: new Container(
                      padding: EdgeInsets.all(16),
                      margin: new EdgeInsets.symmetric(vertical: 8.0),
                      height: 3.0,
                      width: _width,
                      color: new Color(0xff00c6ff),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              FadeTransition(
                opacity: milkyAnimation,
                child: new Text(
                  "Has a black hole ",
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              FadeTransition(
                opacity: galaxyAnimation,
                child: new Text(
                  "At its center",
                  style: TextStyle(
                      fontSize: 44,
                      color: Colors.white,
                      fontStyle: FontStyle.normal),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    milkyController.dispose();
    galaxyController.dispose();
    livingController.dispose();
    super.dispose();
  }
}

class PageTwoView extends StatefulWidget {
  final String imageURL;
  // final living_animation = AnimationController(vsync: this, duration: Duration(seconds: 3))
  const PageTwoView(this.imageURL, {Key key}) : super(key: key);
  _PageTwoViewState createState() => _PageTwoViewState(imageURL);
}
