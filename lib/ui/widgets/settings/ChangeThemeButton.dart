import 'package:flutter/material.dart';

class ChangeThemeButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;

  ChangeThemeButton(this.title, this.icon, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      textColor: const Color(0xFF807a6b),
      padding: EdgeInsets.all(20.0),
      onPressed: this.onPressed,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: <Widget>[
                  Icon(this.icon),
                  SizedBox(width: 20.0),
                  Text(this.title),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/colorwheel.png"),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(0),
                )),
          ),
        ],
      ),
    );
  }
}
