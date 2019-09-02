import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/authenticator/authenticate/FirebaseAuthenticator.dart';
import 'package:galaxy/authenticator/authenticator_controller.dart';
import 'package:galaxy/authenticator/register/email_password_registration.dart';
import './bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  @override
  RegistrationState get initialState => InitialRegistrationState();
  AuthenticatorController authenticatorController =
      AuthenticatorController(new FirebaseAuthenticator());
  @override
  Stream<RegistrationState> mapEventToState(
    RegistrationEvent event,
  ) async* {
     if (event is RegisterWithEmailAndPasswordEvent) {
      yield await authenticatorController
          .createUser(EmailAndPasswordRegistrationAuth(event.email, event.password));
    }
  }
}
