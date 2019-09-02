import 'package:galaxy/authenticator/authenticate/Authenticator.dart';
import 'package:galaxy/authenticator/authenticate/Authenticator_state.dart';
import 'package:galaxy/authenticator/bloc/login/login_state.dart'
    as login_state;
import 'package:galaxy/authenticator/bloc/logout/bloc.dart';
import 'package:galaxy/authenticator/bloc/register/registration_state.dart'
    as registration_state;
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/log/base_log.dart';
import 'package:galaxy/authenticator/log/states/login_states.dart';
import 'package:galaxy/authenticator/log/states/logout_states.dart';
import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:galaxy/authenticator/register/base_registration.dart';
import 'package:galaxy/authenticator/register/reg_state.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/email_password_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/facebook_auth_callback.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/gmail_auth_callback.dart';

class AuthenticatorController {
  static Authenticator _authenticator;
  BaseLog logMethod;
  BaseRegistration registrationMethod;

  AuthenticatorController._privateConstructor();
  static final AuthenticatorController _instance =
      AuthenticatorController._privateConstructor();

  factory AuthenticatorController(Authenticator authenticator) {
    _authenticator = _authenticator ?? authenticator;
    return _instance;
  }
  Future<LogoutState> logout() async {
    AuthenticatorState state = await _authenticator.logout();
    if (state is AuthenticatedFailure) {
      return FailedToLoggedOut();
    } else if (state is UnauthenticatedSucceed) {
      BaseLogoutState logoutState = await logMethod.logout();
      if (logoutState is LoggedOutSucceed) {
        return LoggedOut();
      } else {
        return FailedToLoggedOut();
      }
    }
    if (registrationMethod == null)
      return LoggedOut();
    else
      return FailedToLoggedOut();
  }

  Future<login_state.LoginState> login(BaseLog logMethod) async {
    BaseLoginState state = await logMethod.login();
    if (state is ValidationFailure) {
      return _getValidationFailureState(state);
    } else if (state is LoginFailure) {
      return login_state.Failure(state.errorMessage);
    } else if (state is LoginSucceed) {
      AuthenticatorState authState = await _getAuthentucatorState(state.data);
      if (authState is AuthenticatedSucceed) {
        this.logMethod = logMethod;
        return login_state.Succeed(authState.user);
      } else if (authState is AuthenticatedFailure) {
        return login_state.Failure(authState.errorMessage);
      }
    }
    return null;
  }

  Future<bool> isLoggedIn() async {
    return await _authenticator.isLoggedIn();
  }

  Future<AuthenticatedUser> getAuthenticatedUser() async {
    return await _authenticator.getUser();
  }

  login_state.LoginState _getValidationFailureState(ValidationFailure failure) {
    if (failure.type == ValidationType.Email) {
      return login_state.InvalidEmail(failure.errorMessage);
    } else {
      return login_state.InvalidPassword(failure.errorMessage);
    }
  }

  Future<AuthenticatorState> _getAuthentucatorState(
      BaseAuthCallback authCallback) async {
    AuthenticatorState authState;
    if (authCallback is FacebookAuthCallback) {
      authState = await _authenticator.loginWithFacebook(authCallback);
    } else if (authCallback is GmailAuthCallback) {
      authState = await _authenticator.loginWithGmail(authCallback);
    } else if (authCallback is EmailAndPasswordAuthCallback) {
      authState = await _authenticator.loginWithEmailandPassword(authCallback);
    }
    return authState;
  }

  Future<registration_state.RegistrationState> createUser(
      BaseRegistration registrationMethod) async {
    BaseRegistrationState state = await registrationMethod.register();
    if (state is RegValidationFailure) {
      if (state.type == ValidationType.Email) {
        return registration_state.InvalidEmail(state.errorMessage);
      } else {
        return registration_state.InvalidPassword(state.errorMessage);
      }
    } else if (state is RegFailure) {
      return registration_state.RegistrationFailure(state.errorMessage);
    } else if (state is RegSucceed) {
      AuthenticatorState authState = await _getAuthentucatorState(state.data);

      if (state.data is EmailAndPasswordAuthCallback) {
        authState = await _authenticator.createUserWithEmailandPassword(state.data);
      }
      if (authState is AuthenticatedSucceed) {
        this.registrationMethod = registrationMethod;
        return registration_state.RegistrationSucceed(authState.user);
      } else if (authState is AuthenticatedFailure) {
        return registration_state.RegistrationFailure(authState.errorMessage);
      }
    }
    return null;
  }
}
