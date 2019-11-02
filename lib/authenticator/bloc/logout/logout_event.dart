import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogoutEvent extends Equatable {
  LogoutEvent([List props = const []]) : super();
}

class Logout extends LogoutEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
