import 'package:galaxy/authenticator/log/states/login_states.dart';
import 'package:galaxy/authenticator/log/states/logout_states.dart';

abstract class BaseLog {
  Future<BaseLoginState> login(); 
  Future<BaseLogoutState> logout(); 
}
