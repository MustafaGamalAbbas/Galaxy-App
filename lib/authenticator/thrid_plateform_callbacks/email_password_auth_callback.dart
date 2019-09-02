import 'package:galaxy/authenticator/thrid_plateform_callbacks/base_auth_callback.dart';

class EmailAndPasswordAuthCallback extends BaseAuthCallback{
  final String email, password ;

  EmailAndPasswordAuthCallback(this.email, this.password); 
}