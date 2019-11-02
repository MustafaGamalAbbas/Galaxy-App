import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SavingToSharePreferenceEvent extends Equatable {
  SavingToSharePreferenceEvent([List props = const []]) : super();
}

class IsFirstTimeEvent extends SavingToSharePreferenceEvent {
  final bool isFirstTime;
  IsFirstTimeEvent(this.isFirstTime);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RightColorBarEvent extends SavingToSharePreferenceEvent {
  final int rightCornerColor;
  RightColorBarEvent(this.rightCornerColor);

  @override
   List<Object> get props => null;
}

class LeftColorBarEvent extends SavingToSharePreferenceEvent {
  final int leftCornerColor;
  LeftColorBarEvent(this.leftCornerColor);

  @override
   List<Object> get props => null;
}

class BackgroundColorEvent extends SavingToSharePreferenceEvent {
  final int backgroundColor;
  BackgroundColorEvent(this.backgroundColor);

  @override
   List<Object> get props => null;
}
