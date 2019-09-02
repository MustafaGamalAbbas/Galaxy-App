import 'package:galaxy/authenticator/constants/Strings.dart';
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/register/base_registration.dart';
import 'package:galaxy/authenticator/register/reg_state.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/email_password_auth_callback.dart';
import 'package:galaxy/authenticator/validators/validator.dart';
import 'package:galaxy/authenticator/validators/validators_states/validators_states.dart';

class EmailAndPasswordRegistrationAuth extends BaseRegistration{
  final String email, password;
  Validator emailValidator, passwordValidator;
  EmailAndPasswordRegistrationAuth(this.email, this.password,
      {this.emailValidator, this.passwordValidator});
  @override
  Future<BaseRegistrationState> register() async{
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
      return RegSucceed<EmailAndPasswordAuthCallback>(new EmailAndPasswordAuthCallback(email, password));
    } else if (emailState is ValidatorError) {
      return RegValidationFailure(
          errorMessage: emailState.message, type: ValidationType.Email);
    } else if (passwordState is ValidatorError) {
      return RegValidationFailure(
          errorMessage: passwordState.message, type: ValidationType.Password);
    }
    return null;
  }
  

}