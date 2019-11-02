import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:galaxy/utilities/ConnectionStatus.dart';
import './bloc.dart';

class InternetconnectionBloc
    extends Bloc<InternetconnectionEvent, InternetconnectionState> {

 
    InternetconnectionBloc(){
      this.add(GetEvent());
    }
  @override
  InternetconnectionState get initialState => Disconnected();

  @override
  Stream<InternetconnectionState> mapEventToState(
    InternetconnectionEvent event,
  ) async* {
     bool status =
        await ConnectionStatusSingleton.getInstance().checkConnection();
        yield status ? Connected() : Disconnected();
  }

  
}
