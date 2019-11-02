import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/authenticator/bloc/login/bloc.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/customWidgets/CustomButton.dart';
import 'package:galaxy/ui/widgets/signup/SignUp.dart';
import 'package:galaxy/ui/widgets/splashScreen/SplashScreen.dart';

import 'SocialMediaSeparator.dart';

class LoginWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginScreen();
  }
}

class LoginScreen extends State<StatefulWidget> {
  
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
      body: BlocProvider<LoginBloc>(
        builder: (context) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is Succeed) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              openSplashScreen(context);
            });
          }
          return Center(
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold), () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginWithEmailAndPasswordEvent(
                              emailController.text, passwordController.text));
                      /* User user = new User("Null", emailController.text,
                          passwordController.text);
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
                            Toast.show(
                                "You have logged in successfully!", context);
                          } else {
                            print("Oh ! I got some error : " + value.message);
                          }
                        });
                      }*/
                    }),
                    SocialMediaSeparator(),
                    CustomButton(
                        "Login with Facabook",
                        Color(0xFF4267b2),
                        Style.baseTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), () async {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginWithFacebookEvent());
                    }),
                    SizedBox(
                      height: 15.0,
                    ),
                    CustomButton(
                        "Login with Gmail",
                        Color(0xFFD44638),
                        Style.baseTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold), () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(LoginWithGoogleEvent());
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
          );
        }),
      ),
    );
  }
}
