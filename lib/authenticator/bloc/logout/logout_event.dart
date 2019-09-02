import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogoutEvent extends Equatable {
  LogoutEvent([List props = const []]) : super(props);
}

class Logout extends LogoutEvent {}
