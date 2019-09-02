import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationState extends Equatable {
  RegistrationState([List props = const []]) : super(props);
}

class InitialRegistrationState extends RegistrationState {}
class Registering extends RegistrationState {}
class InvalidEmail extends RegistrationState {
  final String validationMessage;
  InvalidEmail(this.validationMessage);
}

class InvalidPassword extends RegistrationState {
  final String validationMessage;
  InvalidPassword(this.validationMessage);
}

class  RegistrationFailure extends RegistrationState {
  final String failureMessage;
   RegistrationFailure(this.failureMessage);
}

class  RegistrationSucceed extends RegistrationState {
  final AuthenticatedUser user;

   RegistrationSucceed(this.user);
}
