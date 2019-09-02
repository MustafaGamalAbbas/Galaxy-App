import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SavingToSharePreferenceEvent extends Equatable {
  SavingToSharePreferenceEvent([List props = const []]) : super(props);
}

class IsFirstTimeEvent extends SavingToSharePreferenceEvent {
  final bool isFirstTime;
  IsFirstTimeEvent(this.isFirstTime);
}

class RightColorBarEvent extends SavingToSharePreferenceEvent {
  final int rightCornerColor;
  RightColorBarEvent(this.rightCornerColor);
}

class LeftColorBarEvent extends SavingToSharePreferenceEvent {
  final int leftCornerColor;
  LeftColorBarEvent(this.leftCornerColor);
}

class BackgroundColorEvent extends SavingToSharePreferenceEvent {
  final int backgroundColor;
  BackgroundColorEvent(this.backgroundColor);
}
