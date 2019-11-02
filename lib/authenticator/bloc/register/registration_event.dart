import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RegistrationEvent extends Equatable {
  RegistrationEvent([List props = const []]) : super();
}

 
class RegisterWithEmailAndPasswordEvent extends RegistrationEvent {
  final String email, password;
  RegisterWithEmailAndPasswordEvent(this.email, this.password);

  @override
  // TODO: implement props
  List<Object> get props => null;
}