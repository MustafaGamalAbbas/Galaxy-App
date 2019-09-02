 
import 'package:galaxy/authenticator/constants/Strings.dart';
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/log/states/login_states.dart';
import 'package:galaxy/authenticator/log/states/logout_states.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/email_password_auth_callback.dart';
import 'package:galaxy/authenticator/validators/validator.dart';
import 'package:galaxy/authenticator/validators/validators_states/validators_states.dart';

import 'base_log.dart';

class EmailAndPasswordAuthLog extends BaseLog {
  final String email, password;
  Validator emailValidator, passwordValidator;
  EmailAndPasswordAuthLog(this.email, this.password,
      {this.emailValidator, this.passwordValidator});

  
 @override
  Future<BaseLoginState> login() async {
    emailValidator = emailValidator ??
        Validator(
            input: email,
            pattern: emailPattern,
            errorMessage:
                "Please enter a valid email address.\n ex: example@x.com");
    passwordValidator = passwordValidator ??
        Validator(
            input: password,
            pattern: passwordPattern,
            errorMessage: "Password must be at least 6 characters.");

    ValidatorState passwordState = passwordValidator.valid();
    ValidatorState emailState = emailValidator.valid();

    if (emailState is ValidatedSucceed && passwordState is ValidatedSucceed) {
      return LoginSucceed<EmailAndPasswordAuthCallback>(new EmailAndPasswordAuthCallback(email, password));
    } else if (emailState is ValidatorError) {
      return ValidationFailure(
          errorMessage: emailState.message, type: ValidationType.Email);
    } else if (passwordState is ValidatorError) {
      return ValidationFailure(
          errorMessage: passwordState.message, type: ValidationType.Password);
    }
    return null;
  }

  @override
  Future<BaseLogoutState> logout() async {
     return LoggedOutSucceed();
  }

 
  
}
