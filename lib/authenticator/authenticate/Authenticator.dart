import 'package:galaxy/authenticator/models/authenticated_user.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';

import 'Authenticator_state.dart';

abstract class Authenticator {
  Future<AuthenticatorState> createUserWithEmailandPassword(
      BaseAuthCallback authCallback);

  Future<AuthenticatorState> loginWithPhoneNumber(
      BaseAuthCallback authCallback);

  Future<AuthenticatorState> loginWithEmailandPassword(
      BaseAuthCallback authCallback);

  Future<AuthenticatorState> loginWithFacebook(BaseAuthCallback authCallback);

  Future<AuthenticatorState> loginWithGmail(BaseAuthCallback authCallback);

  Future<AuthenticatorState> logout();

  Future<bool> isLoggedIn();
  Future<AuthenticatedUser> getUser();
}
