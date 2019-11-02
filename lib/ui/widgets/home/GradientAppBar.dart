import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/ui/widgets/planetsSearchWidget/CustomSearchDelegate.dart';
import 'package:galaxy/ui/widgets/settings/Settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;
  GradientAppBar(this.title);
  int leftCorner, rightCorner;
  Future<int> getGriedents() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    rightCorner = prefs.getInt('rightCorner') ?? 0xFF3366FF;
    leftCorner = prefs.getInt('leftCorner') ?? 0xFF00CCFF;
    return prefs.getInt('leftCorner') ?? 0xFF00CCFF;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return FutureBuilder<int>(
      future: getGriedents(),
      builder: (context, state) {
        if(state.hasData){
         return Container(
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
                          colors: [
                             Color(rightCorner),
                            Color(leftCorner),
                           
                          ],
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
        else 
        return Container(width: 0.0,height: 0.0,);
      },
    );
  /*  return BlocProvider(
      builder: (context) =>
          FetchingSharedPreferenceBloc()..dispatch(GradientColor()),
      child: BlocBuilder<FetchingSharedPreferenceBloc,
          FetchingSharedPreferenceState>(
        builder: (context, state) {
          if (state is WaitingForConnection) {
            return new Container(width: 0.0, height: 0.0);
          } else if (state is GradientColorsSharedpreferenceState) {
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
                          colors: [
                            Color(state.leftCorner),
                            Color(state.rightCorner)
                          ],
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
          } else {
            return new Container(width: 0.0, height: 0.0);
          }
        },
      ),
    );*/
  }
}
