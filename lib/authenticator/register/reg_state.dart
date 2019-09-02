
import 'package:flutter/material.dart';
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';

abstract class BaseRegistrationState {}

class RegValidationFailure extends BaseRegistrationState {
  final String errorMessage;
  ValidationType type = ValidationType.None;
  RegValidationFailure({@required this.errorMessage, this.type});
}

class RegSucceed<T extends BaseAuthCallback> extends BaseRegistrationState {
  final T data;
  RegSucceed(this.data);
}

class RegFailure extends BaseRegistrationState {
  ErrorType type = ErrorType.None ; 
  final String errorMessage;
  int code;
  RegFailure({@required this.errorMessage, this.code , this.type});
}