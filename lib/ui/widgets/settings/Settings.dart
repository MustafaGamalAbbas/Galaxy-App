import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings/widgets/SettingsButton.dart';
import 'package:flutter_settings/widgets/SettingsIcon.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_bloc.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_event.dart';
import 'package:galaxy/authenticator/bloc/auth/authentication_state.dart';
import 'package:galaxy/authenticator/bloc/logout/bloc.dart';
import 'package:galaxy/authenticator/bloc/logout/logout_bloc.dart';
import 'package:galaxy/authenticator/bloc/logout/logout_state.dart';
import 'package:galaxy/ui/dialogs/ChangeThemeDialog.dart';
import 'package:galaxy/ui/widgets/loginWidget/LoginWidget.dart';
import 'package:galaxy/ui/widgets/settings/ChangeThemeButton.dart';

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
            print("LoggedOut");
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _navigateToLoginWidget(context);
            });
          }
          return Column(
            children: <Widget>[
              SettingsButton(
                  title: "Change Theme",
                  icon: SettingsIcon(
                    icon: Icons.track_changes,
                    
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => ChangeThemeDialog());
                  }),
              BlocProvider(
                builder: (context) =>
                    AuthenticationBloc()..add(CurrentStatus()),
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, status) {
                  if (status is Authenticated) {
                    return SettingsButton(
                        icon: SettingsIcon(
                          icon: Icons.exit_to_app,
                          backgroundColor: Colors.blueAccent,
                        ),
                        title: "Log out",
                        caption: status.user.name ?? status.user.email,
                        onPressed: () {
                          print("print()");
                          BlocProvider.of<LogoutBloc>(context).add(Logout());
                        });
                  } else {
                    return SettingsButton(
                        icon: SettingsIcon(
                          icon: Icons.exit_to_app,
                          backgroundColor: Colors.blueAccent,
                        ),
                        title: "Log out",
                        caption: "Not Authenticated",
                        onPressed: () {
                          print("print()");
                          BlocProvider.of<LogoutBloc>(context).add(Logout());
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
