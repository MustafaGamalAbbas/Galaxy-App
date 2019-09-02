import 'package:firebase_database/firebase_database.dart';
import 'package:galaxy/repositories/base_repositories/firebase_repository/base_serializable.dart';
import 'package:json_annotation/json_annotation.dart';
 
part 'Planet.g.dart';

@JsonSerializable()
class Planet extends BaseSerializable {
   String id;
   String name;
   String location;
   String distance;
   String gravity;
   String description;
   String image;
   String picture;
   String youtubeVideoId;
    
   Planet(
      this.id,
      this.name,
      this.location,
      this.distance,
      this.gravity,
      this.description,
      this.image,
      this.picture,
      this.youtubeVideoId) : super.fromJson(null);
  
  factory Planet.fromJson(Map<String, dynamic> json) => _$PlanetFromJson(json);
  Map<String, dynamic> toJson() => _$PlanetToJson(this);


 /* Planet.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        name = snapshot.value["name"],
        location = snapshot.value["location"],
        distance = snapshot.value["distance"],
        gravity = snapshot.value["gravity"],
        description = snapshot.value["description"],
        image = snapshot.value["image"],
        picture = snapshot.value["picture"],
        youtubeVideoId = snapshot.value["youtubeVideoId"];*/
}
 
List<Planet> planets = new List<Planet>();
