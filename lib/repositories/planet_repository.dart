

import 'package:galaxy/models/Planet.dart';
import 'package:galaxy/repositories/base_repositories/firebase_repository/firebase_online_repository.dart';

class PlanetRepository extends FirebaseOnlineRepository<Planet>{
 
  @override
  String getUrl() {
     return "/galaxy/planets";
  }
  
  @override
  Planet getObject(json) {
     return  Planet.fromJson(json);
  }

   

} 