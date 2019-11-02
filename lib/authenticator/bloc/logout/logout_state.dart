import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogoutState extends Equatable {
  LogoutState([List props = const []]) : super();
}

class InitialLogoutState extends LogoutState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoggedOut extends LogoutState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class FailedToLoggedOut extends LogoutState{
  @override
  // TODO: implement props
  List<Object> get props => null;
}