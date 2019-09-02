import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogoutState extends Equatable {
  LogoutState([List props = const []]) : super(props);
}

class InitialLogoutState extends LogoutState {}

class LoggedOut extends LogoutState{}

class FailedToLoggedOut extends LogoutState{}