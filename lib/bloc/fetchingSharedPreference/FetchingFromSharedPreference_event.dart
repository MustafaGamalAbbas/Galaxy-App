import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FetchingSharedPreferenceEvent extends Equatable {
  FetchingSharedPreferenceEvent([List props = const []]) : super();
}

class IsFirstTime extends FetchingSharedPreferenceEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class BackGroundColor extends FetchingSharedPreferenceEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class GradientColor extends FetchingSharedPreferenceEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}