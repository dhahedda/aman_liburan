// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) {
  return LocationResponse(
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
