import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:galaxy/authenticator/authenticate/FirebaseAuthenticator.dart';
import 'package:galaxy/authenticator/authenticator_controller.dart';
import 'package:galaxy/authenticator/log/email_passwrod_log.dart';
import 'package:galaxy/authenticator/log/facebook_log.dart';
import 'package:galaxy/authenticator/log/gmail_log.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticatorController authenticatorController =
      new AuthenticatorController(FirebaseAuthenticator());
  @override
  LoginState get initialState => Uninitialized();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginWithGoogleEvent) {
      yield await authenticatorController.login(GmailAuthLog());
    } else if (event is LoginWithFacebookEvent) {
      yield await authenticatorController.login(FacebookAuthLog());
    } else if (event is LoginWithEmailAndPasswordEvent) {
      yield await authenticatorController
          .login(EmailAndPasswordAuthLog(event.email, event.password));
    }
  }
}
