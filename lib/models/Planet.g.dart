// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Planet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Planet _$PlanetFromJson(Map<String, dynamic> json) {
  return Planet(
    json['id'] as String,
    json['name'] as String,
    json['location'] as String,
    json['distance'] as String,
    json['gravity'] as String,
    json['description'] as String,
    json['image'] as String,
    json['picture'] as String,
    json['youtubeVideoId'] as String,
  );
}

Map<String, dynamic> _$PlanetToJson(Planet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'distance': instance.distance,
      'gravity': instance.gravity,
      'description': instance.description,
      'image': instance.image,
      'picture': instance.picture,
      'youtubeVideoId': instance.youtubeVideoId,
    };
