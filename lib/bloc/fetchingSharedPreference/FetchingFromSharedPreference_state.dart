import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchingSharedPreferenceState extends Equatable {
  FetchingSharedPreferenceState([List props = const []]) : super(props);
}

class InitialSharedpreferenceState extends FetchingSharedPreferenceState {}
class WaitingForConnection extends FetchingSharedPreferenceState {}
class FirstTimeSharedpreferenceState extends FetchingSharedPreferenceState {
  final bool isFirstTime;
  FirstTimeSharedpreferenceState(this.isFirstTime);
}
class GradientColorsSharedpreferenceState extends FetchingSharedPreferenceState {
  final int rightCorner, leftCorner;
  GradientColorsSharedpreferenceState(this.rightCorner, this.leftCorner);
 }
class BackgroundSharedpreferenceState extends FetchingSharedPreferenceState {
  final int background;

  BackgroundSharedpreferenceState(this.background);
  
  }
