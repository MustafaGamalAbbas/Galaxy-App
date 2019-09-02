import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginWithGoogleEvent extends LoginEvent {}

class LoginWithFacebookEvent extends LoginEvent {}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final String email, password;
  LoginWithEmailAndPasswordEvent(this.email, this.password);
}
