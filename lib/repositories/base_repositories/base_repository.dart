import 'package:galaxy/repositories/base_repositories/firebase_repository/base_serializable.dart';

abstract class BaseRepository <UrLType,ObjectType>  {
    UrLType getUrl();
    ObjectType getObject(json);
    
}
