import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/bloc/savingToSharePreference/SavingToSharePreference_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SavingToSharePreference_state.dart';

class SavingToSharePreferenceBloc
    extends Bloc<SavingToSharePreferenceEvent, SavingToSharePreferenceState> {
  SharedPreferences _prefs;

  @override
  SavingToSharePreferenceState get initialState =>
      InitialSavingtosharepreferenceState();

  @override
  Stream<SavingToSharePreferenceState> mapEventToState(
    SavingToSharePreferenceEvent event,
  ) async* {
    _prefs = await SharedPreferences.getInstance();
    if (event is IsFirstTimeEvent) {
      _prefs.setBool('isFirstTime', event.isFirstTime).whenComplete(() {
        return SavedSuccessfully();
      }).catchError((onError) {
        return ErrorCaught(onError.message)  ;
      });
    } else if (event is LeftColorBarEvent) {
      _prefs.setInt('leftCorner', event.leftCornerColor).whenComplete(() {
        return SavedSuccessfully();
      }).catchError((onError) {
        return ErrorCaught(onError.message) ;
      });
    }  
     else if (event is RightColorBarEvent) {
      _prefs.setInt('rightCorner', event.rightCornerColor).whenComplete(() {
        return SavedSuccessfully();
      }).catchError((onError) {
        return ErrorCaught(onError.message) ;
      });
    } else if (event is BackgroundColorEvent) {
      print("Background : " );
      _prefs.setInt('background', event.backgroundColor).whenComplete(() {
        return SavedSuccessfully();
      }).catchError((onError) {
        return ErrorCaught(onError.message) ;
      });
    }
  }
}
