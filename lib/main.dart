import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:galaxy/ui/widgets/home/HomeWidget.dart';
import 'package:galaxy/ui/widgets/loginWidget/LoginWidget.dart';
import 'package:galaxy/ui/widgets/noInternetConnection/NoInternetConnection.dart';
import 'package:galaxy/ui/widgets/welcomeScreen/WelcomeWidget.dart';
import 'package:galaxy/utilities/ConnectionStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final databaseReference = FirebaseDatabase.instance.reference();

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

  Future<bool> isFristTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("isFirstTime");
  }
  @override
  Widget build(BuildContext context) {
     Future<FirebaseUser> _getUser() async{
      return await FirebaseAuth.instance.currentUser(); 
    }
    return FutureBuilder<bool>(
        future: ConnectionStatusSingleton.getInstance().checkConnection(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.data.getBool("isFirstTime") == null)
                    return WelcomeWidget();
                  else{
                    return FutureBuilder<FirebaseUser>(
                      future: _getUser(),
                      builder: (context, snapshot) {
                        if(snapshot.hasData&& snapshot.data!=null)
                        return HomeWidget();
                        else 
                         return LoginWidget();
                      }
                    );
                  }  
                });
          }
          else{
            return NoInternetConnectionWidget();
          }
        });
  }
}
