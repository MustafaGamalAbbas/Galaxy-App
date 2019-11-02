import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super();
}

class AppStarted extends AuthenticationEvent {
  @override
 
  List<Object> get props => null;
}

class CurrentStatus extends AuthenticationEvent {
  @override
 
  List<Object> get props => null;
}
