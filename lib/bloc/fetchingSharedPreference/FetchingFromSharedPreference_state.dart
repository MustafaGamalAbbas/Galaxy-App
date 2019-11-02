import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchingSharedPreferenceState extends Equatable {
  FetchingSharedPreferenceState([List props = const []]) : super();
}

class InitialSharedpreferenceState extends FetchingSharedPreferenceState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class WaitingForConnection extends FetchingSharedPreferenceState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class FirstTimeSharedpreferenceState extends FetchingSharedPreferenceState {
  final bool isFirstTime;
  FirstTimeSharedpreferenceState(this.isFirstTime);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class GradientColorsSharedpreferenceState extends FetchingSharedPreferenceState {
  final int rightCorner, leftCorner;
  GradientColorsSharedpreferenceState(this.rightCorner, this.leftCorner);

  @override
  // TODO: implement props
  List<Object> get props => null;
 }
class BackgroundSharedpreferenceState extends FetchingSharedPreferenceState {
  final int background;

  BackgroundSharedpreferenceState(this.background);

  @override
  // TODO: implement props
  List<Object> get props => null;
  
  }
