import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Authenticated extends AuthenticationState {
  final AuthenticatedUser user;

  Authenticated(this.user) : super([user]);

}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

}


