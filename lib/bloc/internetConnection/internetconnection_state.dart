import 'package:meta/meta.dart';

@immutable
abstract class InternetconnectionState {}
  
class Connected extends InternetconnectionState {}
class Disconnected extends InternetconnectionState {}
