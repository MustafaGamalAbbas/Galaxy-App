import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class Uninitialized extends LoginState {}

class InvalidEmail extends LoginState {
  final String validationMessage;
  InvalidEmail(this.validationMessage);
}

class InvalidPassword extends LoginState {
  final String validationMessage;
  InvalidPassword(this.validationMessage);
}

class LoggingIn extends LoginState {}

class Failure extends LoginState {
  final String failureMessage;
  Failure(this.failureMessage);
}

class Succeed extends LoginState {
  final AuthenticatedUser user;

  Succeed(this.user);
}
