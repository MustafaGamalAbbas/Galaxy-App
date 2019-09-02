import 'package:galaxy/repositories/base_repositories/base_repository.dart';
import 'package:galaxy/repositories/base_repositories/repository_states.dart';

abstract class BaseOnlineRepository<UrLType, ObjectType>
    implements BaseRepository<UrLType ,ObjectType> {
  Future<RepositoryState> fetchItem();

  Future<RepositoryState> fetchList();

  void pushData(Object data);
}
