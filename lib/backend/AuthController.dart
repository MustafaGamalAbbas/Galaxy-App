import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxy/models/User.dart';

import 'FirebaseCallback.dart';

class AuthController {
  String statusMsg = "Account Created Successfully";
  Future<FirebaseCallback> createUser(User userData) async {
    FirebaseCallback callback;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
          email: userData.email,
          password: userData.password,
        )
        .catchError((error) {
          callback = new FirebaseCallback(false, error.message);
        })
        .whenComplete(() {})
        .then((value) {
          if (value != null) {}
        });
    return callback != null ? callback : new FirebaseCallback(true, statusMsg);
  }

  Future<FirebaseCallback> loginUser(User userData) async {
    FirebaseCallback callback;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: userData.email, password: userData.password)
        .catchError((error) {
      callback = new FirebaseCallback(false, error.message);
    });
    return callback != null
        ? callback
        : new FirebaseCallback(true, "Login Successfully");
  }

  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<String> signInWithFacebok(String accessToken) async {
    /* FirebaseUser user = await FirebaseAuth.instance
        .signInWithFacebook(accessToken: accessToken);*/
    return null;
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }
}
