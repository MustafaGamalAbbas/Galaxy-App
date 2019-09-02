import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/repositories/base_repositories/repository_states.dart';
import 'package:galaxy/repositories/planet_repository.dart';
import './bloc.dart';

class PlanetsBloc extends Bloc<PlanetsEvent, PlanetsState> {
  @override
  PlanetsState get initialState => InitialPlanetsState();
  PlanetRepository planetRepository = new PlanetRepository();
  @override
  Stream<PlanetsState> mapEventToState(
    PlanetsEvent event,
  ) async* {
    
    PlanetsState planetState = OnWaiting();
    yield planetState ; 
    await planetRepository.fetchList().catchError((onError) {
       planetState  = OnErrorDataState(onError.message.toString());
        
    }).then((state) {
      if (state is SyncDataSucceedState) {
        planetState = OnReceiveDataState(state.data);
       
      }
    });
   yield planetState; 
  
  }
}
