import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SavingToSharePreferenceState extends Equatable {
  SavingToSharePreferenceState([List props = const []]) : super();
}

class InitialSavingtosharepreferenceState extends SavingToSharePreferenceState {
  @override
   List<Object> get props => null;
}
 
class SavedSuccessfully extends SavingToSharePreferenceState{
  @override
   List<Object> get props => null;
}
class ErrorCaught extends SavingToSharePreferenceState{
  int code ;
  final String message ;

  ErrorCaught(this.message);

  @override
   List<Object> get props => null;  
}