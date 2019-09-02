import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlanetsEvent extends Equatable {
  PlanetsEvent([List props = const []]) : super(props);
}
class GetPlanetsListEvent extends PlanetsEvent {}