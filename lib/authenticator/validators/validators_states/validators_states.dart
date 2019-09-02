
abstract class ValidatorState {}

class ValidatorError extends ValidatorState{ 
  final String message ; 
  int code ;

  ValidatorError(this.message); 
  
}
class ValidatedSucceed extends ValidatorState{}