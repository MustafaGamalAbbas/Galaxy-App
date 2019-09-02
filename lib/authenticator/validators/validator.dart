import 'package:flutter/material.dart';
import 'package:galaxy/authenticator/validators/validators_states/validators_states.dart';
import 'package:galaxy/authenticator/validators/base_validator.dart';

class Validator extends BaseValidator {
  final String input;
  Pattern pattern = r"(\w+|[a-zA-Z0-9]|[',. -])+$";
  String errorMessage = "Doesn't Match with the pattern.";

  Validator({@required this.input, this.pattern, this.errorMessage});

  @override
  ValidatorState valid() {
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(input))
      return ValidatorError(errorMessage);
    else
      return ValidatedSucceed();
  }
}
