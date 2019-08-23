import 'package:flutter/material.dart';
import 'package:galaxy/styles/Text_Style.dart';
import 'package:galaxy/ui/customWidgets/Separator.dart';

class SocialMediaSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 35),
      child: new Row(
        children: <Widget>[
          Expanded(
            child: Separator(),
            flex: 1,
          ),
          Expanded(
            child: Center(
              child: Text(
                "OR",
                style: Style.headerTextStyle.copyWith(color: Color(0xFF00CCFF)),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Separator(),
            flex: 1,
          )
        ],
      ),
    );
  }
}
