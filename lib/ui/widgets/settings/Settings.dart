import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_bloc.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_event.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_state.dart';
import 'package:galaxy/authenticator/bloc/logout/bloc.dart';
import 'package:galaxy/authenticator/bloc/logout/logout_bloc.dart';
import 'package:galaxy/authenticator/bloc/logout/logout_state.dart';
import 'package:galaxy/ui/dialogs/ChangeThemeDialog.dart';
import 'package:galaxy/ui/widgets/loginWidget/LoginWidget.dart';
import 'package:galaxy/ui/widgets/settings/ChangeThemeButton.dart';
import 'package:galaxy/ui/widgets/settings/SettingsButton.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  _SettingsState createState() => _SettingsState();
}

_navigateToLoginWidget(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginWidget()),
      (Route<dynamic> route) => false);
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Icon(Icons.settings),
            SizedBox(
              width: 10,
            ),
            Text("Settings"),
          ],
        ),
      ),
      body: BlocProvider(
        builder: (context) => LogoutBloc(),
        child: BlocBuilder<LogoutBloc, LogoutState>(builder: (context, state) {
          if (state is LoggedOut) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToLoginWidget(context);
            });
          }
          return Column(
            children: <Widget>[
              ChangeThemeButton("Change Theme", Icons.track_changes, () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => ChangeThemeDialog());
              }),
              BlocProvider(
                builder: (context) =>
                    AuthenticationBloc()..dispatch(CurrentStatus()),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, status) {
                  if (status is Authenticated) {
                    return SettingsButton(Icons.exit_to_app, "Log out",
                        status.user.name ?? status.user.email, () async {
                      BlocProvider.of<LogoutBloc>(context).dispatch(Logout());
                     
                    });
                  } else {
                    return SettingsButton(
                        Icons.exit_to_app, "Log out", "Not Authenticated",
                        () async {
                      BlocProvider.of<LogoutBloc>(context).dispatch(Logout());
                       
                    });
                  }
                }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
