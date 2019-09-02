import 'package:equatable/equatable.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlanetsState extends Equatable {
  PlanetsState([List props = const []]) : super(props);
}

class InitialPlanetsState extends PlanetsState {}

class OnErrorDataState extends PlanetsState{
  final String errorMessage ;
  OnErrorDataState(this.errorMessage); 
}
class OnReceiveDataState extends PlanetsState{
  final List<Planet> planets;

  OnReceiveDataState(this.planets); 
}
class OnWaiting extends  PlanetsState {}