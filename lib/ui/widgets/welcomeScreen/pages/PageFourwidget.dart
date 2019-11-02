import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:galaxy/animtions/PulseAnimator.dart';
import 'package:galaxy/bloc/savingToSharePreference/SavingToSharePreference_bloc.dart';
import 'package:galaxy/bloc/savingToSharePreference/SavingToSharePreference_event.dart';
import 'package:galaxy/ui/widgets/loginWidget/LoginWidget.dart';

class _PageFourViewState extends State<PageFourView>
    with TickerProviderStateMixin {
  double _padding = 16;
  final String imageURL;
  double _width = 0, _getStartWidth = 0;
  _PageFourViewState(this.imageURL);
  AnimationController milkyController,
      galaxyController,
      livingController,
      knowMoreController,
      animationController;

  Animation<double> milkyAnimation,
      galaxyAnimation,
      livingAnimation,
      knowMoreAnimation;
  @override
  dispose() {
    animationController.dispose();
    knowMoreController.dispose();
    knowMoreController.dispose();
    galaxyController.dispose();

    super.dispose();
  }

  initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    super.initState();
    _savingBloc = new SavingToSharePreferenceBloc();

    milkyController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    galaxyController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    livingController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    knowMoreController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    milkyAnimation =
        CurvedAnimation(parent: milkyController, curve: Curves.easeInBack);
    galaxyAnimation =
        CurvedAnimation(parent: galaxyController, curve: Curves.easeInBack);

    knowMoreAnimation =
        CurvedAnimation(parent: knowMoreController, curve: Curves.easeInBack);
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
    galaxyController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _getStartWidth = 300;
        printDailyNewsDigest();
      } else if (status == AnimationStatus.dismissed) {}
    });
    animationController.forward();
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {}
    });
    livingController.forward();
  }

  Future<void> printDailyNewsDigest() async {
    try {
      Future.delayed(new Duration(seconds: 1), () {
        knowMoreController.forward();
      });
    } catch (e) {}
  }

  SavingToSharePreferenceBloc _savingBloc;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
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
                  "Has our solar system",
                  style: TextStyle(
                    fontSize: 34,
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
                  "That have a lot of planets",
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontStyle: FontStyle.normal),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 128),
                child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: _getStartWidth,
                    height: 48,
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                      color: new Color(0xff00c6ff),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: RawMaterialButton(
                        child: FadeTransition(
                          opacity: knowMoreAnimation,
                          child: Center(
                            child: PulseAnimator(
                              Text(
                                "Know about them",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal),
                              ),
                            ),
                          ),
                        ),
                        shape: StadiumBorder(),
                        fillColor: new Color(0xff00c6ff),
                        splashColor: new Color(0xFF3366FF),
                        onPressed: () {
                          _savingBloc.add(IsFirstTimeEvent(false));
                          Navigator.pushReplacement(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new LoginWidget()));
                        })),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PageFourView extends StatefulWidget {
  final String imageURL;
  const PageFourView(this.imageURL, {Key key}) : super(key: key);
  _PageFourViewState createState() => _PageFourViewState(imageURL);
}
