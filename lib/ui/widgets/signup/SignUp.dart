import 'package:flutter/material.dart';
import 'package:galaxy/backend/AuthController.dart';
import 'package:galaxy/models/User.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/widgets/splashScreen/SplashScreen.dart';
import 'package:galaxy/utilities/Validator.dart';
import 'package:toast/toast.dart';

class SignUpWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SignUpScreen();
  }
}

class SignUpScreen extends State<StatefulWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String errorEmailText, errorPasswordText, errorNameText;

  Validator validator = new Validator();

  openSplashScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (context) => new SplashScreenWidget()));
  }

  onSignUpPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());
    User user = new User("Null", emailController.text, passwordController.text);
    errorEmailText = Validator.validateEmail(emailController.text);
    errorPasswordText = Validator.validatePassword(passwordController.text);
    if (errorEmailText == null &&
        errorPasswordText == null &&
        errorNameText == null) {
      AuthController authController = new AuthController();
      authController.createUser(user).catchError((error) {
        print(error.message);
      }).then((value) {
        Toast.show(value.message, context,
            gravity: Toast.BOTTOM,
            duration: Toast.LENGTH_LONG,
            textColor: Colors.redAccent);
        if (value.succeeded) {
          print(value.message);

          Toast.show("You have signed up successfully!", context);
          openSplashScreen(context);
        } else {
          print("Oh ! I got some error : " + value.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailField = new Theme(
      data: new ThemeData(
        primaryColor: Color(0xFF00CCFF),
        hintColor: Color(0xFF00CCFF),
        accentColor: Color(0xFF00CCFF),
      ),
      child: TextField(
        controller: emailController,
        obscureText: false,
        style: Style.commonTextStyle.copyWith(color: Color(0xFF00CCFF)),
        decoration: InputDecoration(
            icon: Icon(
              Icons.email,
              color: Color(0xFF00CCFF),
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            errorText: errorEmailText,
            hintText: "Email Address",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );
    final passwordField = new Theme(
      data: new ThemeData(
        primaryColor: Color(0xFF00CCFF),
        hintColor: Color(0xFF00CCFF),
        accentColor: Color(0xFF00CCFF),
      ),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        style: Style.commonTextStyle.copyWith(color: Color(0xFF00CCFF)),
        decoration: InputDecoration(
            icon: Icon(
              Icons.vpn_key,
              color: Color(0xFF00CCFF),
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            hintText: "Password",
            errorText: errorPasswordText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
      ),
    );

    return Scaffold(
      body: new Stack(
        children: <Widget>[
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/5.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 36.0, top: 96, right: 36, bottom: 36),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 100.0,
                      child: Image.asset(
                        "assets/images/Galaxy.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 25.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff01A0C7),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
                        onPressed: () {
                          setState(() {
                            onSignUpPressed();
                          });
                        },
                        child: Text("Create account",
                            textAlign: TextAlign.center,
                            style: Style.baseTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 150.0,left: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Already have an account? Log in",
                          style: Style.headerTextStyle.copyWith(
                              fontSize: 18.0,
                              color: Color(0xFF00CCFF),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
