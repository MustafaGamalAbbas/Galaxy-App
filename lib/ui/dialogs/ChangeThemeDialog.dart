import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galaxy/bloc/fetchingSharedPreference/bloc.dart';
import 'package:galaxy/bloc/savingToSharePreference/SavingToSharePreference_bloc.dart';
import 'package:galaxy/bloc/savingToSharePreference/SavingToSharePreference_event.dart';
import 'package:toast/toast.dart';
import 'package:flutter_colorpicker/material_picker.dart';

class ChangeThemeDialog extends StatefulWidget {
  ChangeThemeDialog({Key key}) : super(key: key);

  ChangeThemeDialogState createState() => ChangeThemeDialogState();
}

class ChangeThemeDialogState extends State<StatefulWidget> {
  ChangeThemeDialogState();
  int backgroundColor;
  int rightToolbarColor;
  int leftToolbarColor;
  SavingToSharePreferenceBloc _sharePreferenceBloc;
  @override
  void initState() {
    super.initState();
    _sharePreferenceBloc = new SavingToSharePreferenceBloc();
  }

  void changeBackgroundColor(Color color) {
     setState(() {
             backgroundColor = color.value;
       _sharePreferenceBloc.add(BackgroundColorEvent(color.value));
     });
  }

  void changeRightCornerToolbarColor(Color color) {
     setState(() {
      rightToolbarColor = color.value;
      _sharePreferenceBloc.add(RightColorBarEvent(color.value));
    });
  }

  void changeLeftCornerToolbarColor(Color color) {
     setState(() {
      leftToolbarColor = color.value;
      _sharePreferenceBloc.add(LeftColorBarEvent(color.value));
    });
  }

  void openColorPickerDialog(Color currentColor, Function callback) {
    showDialog(
      context: context,
      
      builder:(context){ 
        return AlertDialog(
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
          /*child: BlockPicker(
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
      );},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => FetchingSharedPreferenceBloc()..add(GradientColor()),
      child: BlocBuilder<FetchingSharedPreferenceBloc,
          FetchingSharedPreferenceState>(builder: (context, state) {
        if (state is GradientColorsSharedpreferenceState) {
          rightToolbarColor = rightToolbarColor ?? state.rightCorner;
          leftToolbarColor = leftToolbarColor ?? state.leftCorner;
          return Container(
            child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 7.0,
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
                                      Color(rightToolbarColor),
                                      Color(leftToolbarColor)
                                    ],
                                    begin: FractionalOffset(0.0, 0.0),
                                    end: FractionalOffset(1.0, 0.0),
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.clamp),
                              ),
                            ),
                            BlocProvider(
                              builder: (context) =>
                                  FetchingSharedPreferenceBloc()..add(BackGroundColor()),
                              child: BlocBuilder<FetchingSharedPreferenceBloc,
                                  FetchingSharedPreferenceState>(
                                builder: (context, _state) {
                                  if (_state
                                      is BackgroundSharedpreferenceState) {
                                    backgroundColor = backgroundColor ?? _state.background;
                                    return Container(
                                      height: 300,
                                      decoration: new BoxDecoration(
                                        color: Color(backgroundColor),
                                      ),
                                    );
                                  } else
                                    new Container(height: 0.0,width: 0.0,);
                                },
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
                            openColorPickerDialog(
                                Color(backgroundColor), changeBackgroundColor);
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
                                changeLeftCornerToolbarColor);
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
                                changeRightCornerToolbarColor);
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
        } else
          return new Container(width: 0.0,height: 0.0,);
      }),
    );
  }
}
