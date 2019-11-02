import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();
}

class Uninitialized extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InvalidEmail extends LoginState {
  final String validationMessage;
  InvalidEmail(this.validationMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InvalidPassword extends LoginState {
  final String validationMessage;
  InvalidPassword(this.validationMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggingIn extends LoginState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Failure extends LoginState {
  final String failureMessage;
  Failure(this.failureMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Succeed extends LoginState {
  final AuthenticatedUser user;

  Succeed(this.user);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
