import 'package:galaxy/authenticator/log/states/login_states.dart';
import 'package:galaxy/authenticator/log/states/logout_states.dart';
import 'package:galaxy/authenticator/thrid_plateform_callbacks/gmail_auth_callback.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'base_log.dart';

class GmailAuthLog extends BaseLog {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  Future<BaseLoginState> login() async {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account.authentication;
    return new LoginSucceed<GmailAuthCallback>(
        new GmailAuthCallback(auth.accessToken, auth.idToken));
  }

  @override
  Future<BaseLogoutState> logout() async {
    BaseLogoutState state;

    await _googleSignIn.signOut().catchError((error) {
      state = LoggedOutFailed(error.message);
    }).whenComplete(() {
      state = LoggedOutSucceed();
    });

    return state ?? LoggedOutSucceed();
  }
}
