import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ChangeThemeDialog extends StatefulWidget {
  ChangeThemeDialog({Key key}) : super(key: key);

  _ChangeThemeDialogState createState() => _ChangeThemeDialogState();
}

class _ChangeThemeDialogState extends State<ChangeThemeDialog> {
  int backgroundColor;
  int rightToolbarColor;
  int leftToolbarColor;

  void changeBackgroundColor(Color color) {
    print(color.toString());
    setState(() {
      backgroundColor = color.value;
      _saveCornerToolbarColors();
    });
  }

  void changeRightCornerToolbarColor(Color color) {
    print(color.toString());
    setState(() {
      rightToolbarColor = color.value;
      _saveCornerToolbarColors();
    });
  }

  void changeLeftCornerToolbarColor(Color color) {
    print(color.toString());
    setState(() {
      leftToolbarColor = color.value;
      _saveCornerToolbarColors();
    });
  }

  Future<int> _getSavedAppBarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rightToolbarColor = (prefs.getInt('rightCorner') ?? 0xFF3366FF);
    leftToolbarColor = (prefs.getInt('leftCorner') ?? 0xFF00CCFF);
    backgroundColor = (prefs.getInt('background') ?? Colors.purple.value);
    return (prefs.getInt('rightCorner') ?? 0xFF3366FF);
  }

  _saveCornerToolbarColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('rightCorner', rightToolbarColor);
    prefs.setInt('leftCorner', leftToolbarColor);
    prefs.setInt('background', backgroundColor);
  }

  openColorPickerDialog(Color currentColor, Function callback) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          /* child: ColorPicker(
        pickerColor: currentColor,
        onColorChanged: changeColor,
        enableLabel: true,
        pickerAreaHeightPercent: 0.8,
      ),*/
          // Use Material color picker:
          //
          child: MaterialPicker(
            pickerColor: currentColor,
            onColorChanged: callback,
            enableLabel: true, // only on portrait mode
          ),
          //
          // Use Block color picker:
          //
          /* child: BlockPicker(
        pickerColor: currentColor,
        onColorChanged: changeColor,
       ),*/
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Change'),
            onPressed: () {
              // setState(() => currentColor = Color(0xff443a49));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _getSavedAppBarColors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSavedAppBarColors(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Container(
              child: Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 7.0,
                  //backgroundColor: Colors.transparent,
                  child: Card(
                      child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 80,
                                decoration: new BoxDecoration(
                                  gradient: new LinearGradient(
                                      colors: [
                                        Color(leftToolbarColor),
                                        Color(rightToolbarColor)
                                      ],
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                              ),
                              Container(
                                height: 300,
                                decoration: new BoxDecoration(
                                  color: Color(backgroundColor),
                                ),
                              ),
                              // Expanded(...)
                            ],
                          ),

                          /* Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          color: Colors.red,
                        ),
                      ),*/
                          GestureDetector(
                            onTap: () {
                              openColorPickerDialog(Color(backgroundColor),
                                  changeBackgroundColor);
                              Toast.show("center preesed !", context);
                            },
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Image.asset(
                                "assets/images/changeColorIcon.jpg",
                                width: 120,
                                height: 120,
                              ),
                            )),
                          ),
                          GestureDetector(
                            onTap: () {
                              Toast.show("right preesed !", context);
                              openColorPickerDialog(Color(rightToolbarColor),
                                  changeRightCornerToolbarColor);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(top: 24, right: 16),
                                child: Image.asset(
                                  "assets/images/editColorIcon.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Toast.show("left preesed !", context);
                              openColorPickerDialog(Color(leftToolbarColor),
                                  changeLeftCornerToolbarColor);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: 24, left: 16),
                                child: Image.asset(
                                  "assets/images/editColorIcon - left.png",
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))),
            );
          else
            return new Container();
        });
  }
}
