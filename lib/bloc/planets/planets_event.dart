import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlanetsEvent extends Equatable {
  PlanetsEvent([List props = const []]) : super();
}
class GetPlanetsListEvent extends PlanetsEvent {
  @override
  // TODO: implement props
  List<Object> get props => null;
}