import 'package:firebase_auth/firebase_auth.dart';
import 'package:galaxy/authenticator/authenticate/Authenticator.dart';
import 'package:galaxy/authenticator/authenticate/Authenticator_state.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/email_password_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/facebook_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/gmail_auth_callback.dart';

class FirebaseAuthenticator extends Authenticator {
  @override
  Future<AuthenticatorState> createUserWithEmailandPassword(
      BaseAuthCallback authCallback) async {
    AuthenticatorState state;
    if (authCallback is EmailAndPasswordAuthCallback) {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      AuthResult result = await firebaseAuth
          .createUserWithEmailAndPassword(
        email: authCallback.email,
        password: authCallback.password,
      )
          .catchError((error) {
        state = new AuthenticatedFailure(error.message);
      });
      return state ??
          new AuthenticatedSucceed(new AuthenticatedUser(
            name: result.user.displayName,
            email: result.user.email,
            phone: result.user.phoneNumber,
          ));
    }
    return null;
  }

  @override
  Future<AuthenticatorState> loginWithEmailandPassword(
      BaseAuthCallback authCallback) async {
    if (authCallback is EmailAndPasswordAuthCallback) {
      AuthenticatorState callback;
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      AuthResult result = await firebaseAuth
          .signInWithEmailAndPassword(
              email: authCallback.email, password: authCallback.password)
          .catchError((error) {
        callback = new AuthenticatedFailure(error.message);
      });
      return callback ??
          AuthenticatedSucceed(new AuthenticatedUser(
            name: result.user.displayName,
            email: result.user.email,
            phone: result.user.phoneNumber,
          ));
    }
    return null;
  }

  @override
  Future<AuthenticatorState> loginWithFacebook(
      BaseAuthCallback authCallback) async {
    if (authCallback is FacebookAuthCallback) {
      AuthenticatorState state;
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: authCallback.token);

      AuthResult result = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((error) {
        state = new AuthenticatedFailure(error.message);
      });
      return state ??
          AuthenticatedSucceed(new AuthenticatedUser(
            name: result.user.displayName,
            email: result.user.email,
            phone: result.user.phoneNumber,
          ));
    }
    return null;
  }

  @override
  Future<AuthenticatorState> loginWithGmail(
      BaseAuthCallback authCallback) async {
    if (authCallback is GmailAuthCallback) {
      AuthenticatorState state;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: authCallback.accessToken,
        idToken: authCallback.idToken,
      );

      AuthResult result = await FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((error) {
        state = new AuthenticatedFailure(error.message);
      });
      return state ??
          AuthenticatedSucceed(new AuthenticatedUser(
            name: result.user.displayName,
            email: result.user.email,
            phone: result.user.phoneNumber,
          ));
    }
    return null;
  }

  @override
  Future<AuthenticatorState> loginWithPhoneNumber(
      BaseAuthCallback authCallback) {
    return null;
  }

  @override
  Future<AuthenticatorState> logout() async {
    AuthenticatorState state;
    await FirebaseAuth.instance.signOut().catchError((error) {
      state = new AuthenticatedFailure(error.message);
    });
    return state ?? UnauthenticatedSucceed();
  }

  @override
  Future<bool> isLoggedIn() async {
    final currentUser = await FirebaseAuth.instance.currentUser();
    return currentUser != null;
  }

  @override
  Future<AuthenticatedUser> getUser() async {
    final currentUser = await FirebaseAuth.instance.currentUser();

    return AuthenticatedUser(
        name: currentUser.displayName,
        email: currentUser.email,
        phone: currentUser.phoneNumber,
        userId: currentUser.uid);
  }
}
