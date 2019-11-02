import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginWithFacebookEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final String email, password;
  LoginWithEmailAndPasswordEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
