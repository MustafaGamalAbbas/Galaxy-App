import 'package:galaxy/authenticator/models/authenticated_user.dart';

abstract class AuthenticatorState {}

class AuthenticatedSucceed extends AuthenticatorState {
 final  AuthenticatedUser user ;

  AuthenticatedSucceed(this.user); 

}
class UnauthenticatedSucceed extends AuthenticatorState {
}
class AuthenticatedFailure extends AuthenticatorState {
  final String errorMessage ;

  AuthenticatedFailure(this.errorMessage); 

}