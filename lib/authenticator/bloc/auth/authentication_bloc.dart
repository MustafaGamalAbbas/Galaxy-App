import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/authenticator/authenticate/FirebaseAuthenticator.dart';
import 'package:galaxy/authenticator/authenticator_controller.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticatorController authenticatorController =
      AuthenticatorController(FirebaseAuthenticator());
  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is CurrentStatus) {
      bool isLoggedIn = await authenticatorController.isLoggedIn();
      if (isLoggedIn) {
        final user = await authenticatorController.getAuthenticatedUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    }
    else
    yield Uninitialized();
  }
}
