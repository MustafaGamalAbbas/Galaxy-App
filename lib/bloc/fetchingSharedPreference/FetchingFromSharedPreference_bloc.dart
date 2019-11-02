import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './bloc.dart';

class FetchingSharedPreferenceBloc
    extends Bloc<FetchingSharedPreferenceEvent, FetchingSharedPreferenceState> {
  @override
  FetchingSharedPreferenceState get initialState =>
      InitialSharedpreferenceState();
  SharedPreferences prefs;
   
  @override
  Stream<FetchingSharedPreferenceState> mapEventToState(
    FetchingSharedPreferenceEvent event,
  ) async* {
    //yield WaitingForConnection();
    prefs = await SharedPreferences.getInstance();
    if (event is IsFirstTime) {
      FirstTimeSharedpreferenceState state = new FirstTimeSharedpreferenceState(
          prefs.getBool("isFirstTime") ?? true);
      yield state;
    } else if (event is GradientColor) {
      yield GradientColorsSharedpreferenceState(
          (prefs.getInt('rightCorner') ?? 0xFF3366FF),
          (prefs.getInt('leftCorner') ?? 0xFF00CCFF));
    } else if (event is BackGroundColor) {
      print("Calling again ! ");
      yield BackgroundSharedpreferenceState(
          (prefs.getInt('background') ?? Colors.deepPurple.value));
    }
  }
}
