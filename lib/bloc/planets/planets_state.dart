import 'package:equatable/equatable.dart';
import 'package:galaxy/models/Planet.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PlanetsState extends Equatable {
  PlanetsState([List props = const []]) : super();
}

class InitialPlanetsState extends PlanetsState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OnErrorDataState extends PlanetsState{
  final String errorMessage ;
  OnErrorDataState(this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => null; 
}
class OnReceiveDataState extends PlanetsState{
  final List<Planet> planets;

  OnReceiveDataState(this.planets);

  @override
  // TODO: implement props
  List<Object> get props => null; 
}
class OnWaiting extends  PlanetsState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}