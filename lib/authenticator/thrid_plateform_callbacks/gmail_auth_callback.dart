import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';

class GmailAuthCallback extends BaseAuthCallback{
  final String accessToken, idToken;
  GmailAuthCallback(this.accessToken, this.idToken);
}
