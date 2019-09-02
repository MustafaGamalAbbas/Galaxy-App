

abstract class RepositoryState {}

class SyncDataFailureState extends RepositoryState {
  final String errorMessage;
  SyncDataFailureState(this.errorMessage);
}

class SyncDataSucceedState<Object> extends RepositoryState {
  final Object data;
  SyncDataSucceedState(this.data);
}
