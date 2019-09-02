import 'package:flutter/material.dart';
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/log/states/base_log_state.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';

abstract class BaseLoginState extends BaseLogState{}

class ValidationFailure extends BaseLoginState {
  final String errorMessage;
  ValidationType type = ValidationType.None;
  ValidationFailure({@required this.errorMessage, this.type});
}

class LoginSucceed<T extends BaseAuthCallback> extends BaseLoginState {
  final T data;
  LoginSucceed(this.data);
}

class LoginFailure extends BaseLoginState {
  ErrorType type = ErrorType.None ; 
  final String errorMessage;
  int code;
  LoginFailure({@required this.errorMessage, this.code , this.type});
}
