import 'package:equatable/equatable.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super();
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Authenticated extends AuthenticationState {
  final AuthenticatedUser user;

  Authenticated(this.user) : super([user]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';

  @override
  // TODO: implement props
  List<Object> get props => null;

}


