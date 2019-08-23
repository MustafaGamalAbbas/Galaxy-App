import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color _color;
  final TextStyle _style;
  final String _text;
  final Function onPress;
  CustomButton(this._text, this._color, this._style, [this.onPress]);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      borderOnForeground: true,
      color: this._color,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(10, 7.5, 10, 7.5),
        onPressed: onPress,
        child:
            Text(this._text, textAlign: TextAlign.center, style: this._style),
      ),
    );
  }
}
