import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/authenticator/bloc/auth/bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/FetchingFromSharedPreference_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/bloc/internetConnection/bloc.dart';
import 'package:galaxy/ui/widgets/home/HomeWidget.dart';
import 'package:galaxy/ui/widgets/loginWidget/LoginWidget.dart';
import 'package:galaxy/ui/widgets/noInternetConnection/NoInternetConnection.dart';
import 'package:galaxy/ui/widgets/welcomeScreen/WelcomeWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Galaxy'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Home createState() => Home();
}

class Home extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    
   // return ClippingViewTest();
    return BlocProvider(
        builder: (context) => InternetconnectionBloc(),
        child: BlocBuilder<InternetconnectionBloc, InternetconnectionState>(
            builder: (context, snapshot) {
          if (snapshot is Connected) {
            return BlocProvider(
              builder: (context) => FetchingSharedPreferenceBloc()..add(IsFirstTime()),
              child: BlocBuilder<FetchingSharedPreferenceBloc,
                  FetchingSharedPreferenceState>(builder: (context, state) {
                if (state is FirstTimeSharedpreferenceState &&
                    state.isFirstTime)
                  return WelcomeWidget();
                else {
                  return BlocProvider(
                    builder: (context) =>
                        AuthenticationBloc()..add(CurrentStatus()),
                    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, status) {
                      if (status is Authenticated)
                        return HomeWidget();
                      else if( status is Unauthenticated)
                        return LoginWidget();
                        else 
                        return Container(width: 0.0,height: 0.0,);
                    }),
                  );
                } 
              }),
            );
          } else if (snapshot is Disconnected) {
            return NoInternetConnectionWidget();
          }
          else 
          return Container(height: 0.0,width: 0.0,);
        }));
  }
}
