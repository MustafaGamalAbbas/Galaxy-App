import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/authenticator/authenticate/FirebaseAuthenticator.dart';
import 'package:galaxy/authenticator/authenticator_controller.dart';
import './bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  AuthenticatorController authenticatorController =
      new AuthenticatorController(FirebaseAuthenticator()); 
  @override
  LogoutState get initialState => InitialLogoutState();

  @override
  Stream<LogoutState> mapEventToState(
    LogoutEvent event,
  ) async* {
     yield await authenticatorController.logout();
   }
}
