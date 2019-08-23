import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: <Widget>[
          ChangeThemeButton("Change Theme", Icons.track_changes, () {
             showDialog(
                context: context,
                builder: (BuildContext context) => ChangeThemeDialog());
          }),
          SettingsButton(Icons.exit_to_app, "Log out", "Mustafa Gamal", () {
            FirebaseAuth.instance
                .signOut()
                .whenComplete(_navigateToLoginWidget(context));
          }),
        ],
      ),
    );
  }
}
