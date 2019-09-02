import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:galaxy/authenticator/constants/enums.dart';
import 'package:galaxy/authenticator/log/states/login_states.dart';
import 'package:galaxy/authenticator/log/states/logout_states.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/facebook_auth_callback.dart';

import 'base_log.dart';

class FacebookAuthLog extends BaseLog {
  final facebookLogin = FacebookLogin();
  @override
  Future<BaseLoginState> login() async {
    final result = await facebookLogin
        .logInWithReadPermissions(['email', 'public_profile']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        //  final graphResponse = await http.get(
        //                 'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${result.accessToken.token}');
        return LoginSucceed<FacebookAuthCallback>(
            new FacebookAuthCallback(result.accessToken.token));
      case FacebookLoginStatus.cancelledByUser:
        return LoginFailure(
            errorMessage: result.errorMessage, type: ErrorType.CancelledByUser);
      case FacebookLoginStatus.error:
        return LoginFailure(
            errorMessage: result.errorMessage, type: ErrorType.Unknown);
    }

    return null;
  }

  @override
  Future<BaseLogoutState> logout() async {
    BaseLogoutState state;
    await facebookLogin.logOut().catchError((error) {
      state = LoggedOutFailed(error.message);
    }).whenComplete(() {
      state = LoggedOutSucceed();
    });

    return state ?? LoggedOutSucceed();
  }
}
