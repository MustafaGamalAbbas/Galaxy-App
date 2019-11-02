import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/FetchingFromSharedPreference_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/FetchingFromSharedPreference_event.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/widgets/home/HomeWidget.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider(
        builder: (context) => FetchingSharedPreferenceBloc()..add(BackGroundColor()),
        child: BlocBuilder<FetchingSharedPreferenceBloc,
            FetchingSharedPreferenceState>(builder: (context, state) {
          if (state is BackgroundSharedpreferenceState)
            return Stack(
              children: <Widget>[
                Container(
                  color: Colors.white,
                ),
                ClipPath(
                  child: Container(
                    color: Color(state.background),
                  ),
                  clipper: CurveClipper(),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "No Internet Connection",
                          style: Style.subHeaderTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: Center(
                          child: Text(
                            "You are not connected to the internet, Make sure WiFi is on, Airplane mode is off and try again.",
                            textAlign: TextAlign.center,
                            style: Style.subHeaderTextStyle.copyWith(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Container(
                          width: 150,
                          child: RawMaterialButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new HomeWidget()));
                            },
                            shape: StadiumBorder(),
                            fillColor: Colors.white,
                            splashColor: Colors.white70,
                            child: Text(
                              "Retry",
                              style: TextStyle(
                                  color: Color(state.background),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 4,
                        width: 250,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 64.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/no internet connection 1 .png"),
                            fit: BoxFit.fill,
                          ),
                        )),
                  ),
                )
              ],
            );
          else {
            return Container(width: 0.0, height: 0.0);
          }
        }),
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.moveTo(0.0, size.height);
    path.lineTo(0.0, size.height - 250);
    var firstControlPoint = Offset(size.width / 2, size.height - 350);
    var firstEndPoint = Offset(size.width, size.height - 250);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.height, size.width);
    path.lineTo(size.width, size.height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
