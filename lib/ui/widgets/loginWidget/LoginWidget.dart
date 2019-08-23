import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:galaxy/backend/AuthController.dart';
import 'package:galaxy/models/User.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/customWidgets/CustomButton.dart';
import 'package:galaxy/ui/widgets/signup/SignUp.dart';
import 'package:galaxy/ui/widgets/splashScreen/SplashScreen.dart';
import 'package:galaxy/utilities/Validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'SocialMediaSeparator.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreen();
  }
}

class LoginScreen extends State<StatefulWidget> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorEmailText, errorPasswordText, errorNameText;
  openSplashScreen(BuildContext context) {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (context) => new SplashScreenWidget()));
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
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF00CCFF), width: 0.0),
                borderRadius: BorderRadius.circular(32)),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
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
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xFF00CCFF), width: 0.0),
                borderRadius: BorderRadius.circular(32)),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            fillColor: Color(0xFF00CCFF)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/5.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                  child: Image.asset(
                    "assets/images/galaxy.png",
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
                CustomButton(
                    "Login",
                    Color(0xff01A0C7),
                    Style.baseTextStyle.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold), () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  User user = new User(
                      "Null", emailController.text, passwordController.text);
                  errorEmailText =
                      Validator.validateEmail(emailController.text);
                  errorPasswordText =
                      Validator.validatePassword(passwordController.text);

                  if (errorEmailText == null && errorPasswordText == null) {
                    AuthController authController = new AuthController();
                    authController.loginUser(user).catchError((error) {
                      print(error.message);
                    }).then((value) {
                      Toast.show(value.message, context,
                          gravity: Toast.BOTTOM,
                          duration: Toast.LENGTH_LONG,
                          textColor: Colors.redAccent);
                      if (value.succeeded) {
                        print(value.message);
                        openSplashScreen(context);
                        Toast.show("You have logged in successfully!", context);
                       } else {
                        print("Oh ! I got some error : " + value.message);
                      }
                    });
                  }
                }),
                SocialMediaSeparator(),
                CustomButton(
                    "Login with Facabook",
                    Color(0xFF4267b2),
                    Style.baseTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold), () async {
                  final facebookLogin = FacebookLogin();
                  final result = await facebookLogin
                      .logInWithReadPermissions(['email', 'public_profile']);

                  switch (result.status) {
                    case FacebookLoginStatus.loggedIn:
                      final graphResponse = await http.get(
                          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
                      print(graphResponse.body);
                      AuthCredential credential =
                          FacebookAuthProvider.getCredential(
                              accessToken: result.accessToken.token);

                      FirebaseUser firebaseUser = (await FirebaseAuth.instance
                              .signInWithCredential(credential))
                          .user;
                      openSplashScreen(context);

                      Toast.show("You have logged in successfully! ", context);

                      break;
                    case FacebookLoginStatus.cancelledByUser:
                      Toast.show("The user has cancelled it ", context);

                      break;
                    case FacebookLoginStatus.error:
                      print("There is some error " + result.errorMessage);
                      Toast.show("There is some error " + result.errorMessage,
                          context);
                      break;
                  }
                }),
                SizedBox(
                  height: 15.0,
                ),
                CustomButton(
                    "Login with Gmail",
                    Color(0xFFD44638),
                    Style.baseTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold), () async {
                  GoogleSignInAccount account = await _googleSignIn.signIn();
                  GoogleSignInAuthentication auth =
                      await account.authentication;
                  final AuthCredential credential =
                      GoogleAuthProvider.getCredential(
                    accessToken: auth.accessToken,
                    idToken: auth.idToken,
                  );

                  await FirebaseAuth.instance.signInWithCredential(credential);
                  Toast.show("You have logged in successfully! ", context);
                  openSplashScreen(context);
                }),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new SignUpWidget()));
                    },
                    child: Text(
                      "Create new account!",
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
    );
  }
}
