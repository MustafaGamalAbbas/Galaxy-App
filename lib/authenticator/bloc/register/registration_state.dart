import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationState extends Equatable {
  RegistrationState([List props = const []]) : super();
}

class InitialRegistrationState extends RegistrationState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class Registering extends RegistrationState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class InvalidEmail extends RegistrationState {
  final String validationMessage;
  InvalidEmail(this.validationMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class InvalidPassword extends RegistrationState {
  final String validationMessage;
  InvalidPassword(this.validationMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class  RegistrationFailure extends RegistrationState {
  final String failureMessage;
   RegistrationFailure(this.failureMessage);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class  RegistrationSucceed extends RegistrationState {
  final AuthenticatedUser user;

   RegistrationSucceed(this.user);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
