import 'package:galaxy/authenticator/register/reg_state.dart';

abstract class BaseRegistration {
  Future<BaseRegistrationState> register(); 
}