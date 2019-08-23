import 'package:firebase_database/firebase_database.dart';

class Planet {
  final String id;
  final String name;
  final String location;
  final String distance;
  final String gravity;
  final String description;
  final String image;
  final String picture;
  final String youtubeVideoId;

  const Planet(
      {this.id,
      this.name,
      this.location,
      this.distance,
      this.gravity,
      this.description,
      this.image,
      this.picture,
      this.youtubeVideoId});

  Planet.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.value["id"],
        name = snapshot.value["name"],
        location = snapshot.value["location"],
        distance = snapshot.value["distance"],
        gravity = snapshot.value["gravity"],
        description = snapshot.value["description"],
        image = snapshot.value["image"],
        picture = snapshot.value["picture"],
        youtubeVideoId = snapshot.value["youtubeVideoId"];
}

List<Planet> planets = new List<Planet>();
