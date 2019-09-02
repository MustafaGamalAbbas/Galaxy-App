import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchingSharedPreferenceEvent extends Equatable {
  FetchingSharedPreferenceEvent([List props = const []]) : super(props);
}

class IsFirstTime extends FetchingSharedPreferenceEvent {}
class BackGroundColor extends FetchingSharedPreferenceEvent {}
class GradientColor extends FetchingSharedPreferenceEvent {}