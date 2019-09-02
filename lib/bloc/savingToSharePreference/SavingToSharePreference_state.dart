import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SavingToSharePreferenceState extends Equatable {
  SavingToSharePreferenceState([List props = const []]) : super(props);
}

class InitialSavingtosharepreferenceState extends SavingToSharePreferenceState {}
 
class SavedSuccessfully extends SavingToSharePreferenceState{}
class ErrorCaught extends SavingToSharePreferenceState{
  int code ;
  final String message ;

  ErrorCaught(this.message);  
}