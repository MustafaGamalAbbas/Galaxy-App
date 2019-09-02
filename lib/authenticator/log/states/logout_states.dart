import 'package:galaxy/authenticator/log/states/base_log_state.dart';

abstract class BaseLogoutState extends BaseLogState {}

class LoggedOutSucceed extends BaseLogoutState {}

class LoggedOutFailed extends BaseLogoutState {
  final String errorMessage ;

  LoggedOutFailed(this.errorMessage); 
}
