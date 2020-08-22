// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
    id: json['id'] == null
        ? null
        : Id.fromJson(json['id'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'id': instance.id,
    };

Id _$IdFromJson(Map<String, dynamic> json) {
  return Id(
    placeCategory: json['placeCategory'] as int,
    placeDescription: json['placeDescription'] as String,
    placeHourClose: json['placeHourClose'] as String,
    placeHourOpen: json['placeHourOpen'] as String,
    placeId: json['placeId'] as String,
    placeIsOpen: json['placeIsOpen'] as bool,
    placeLatitude: (json['placeLatitude'] as num)?.toDouble(),
    placeLocation: json['placeLocation'] as String,
    placeLongitude: (json['placeLongitude'] as num)?.toDouble(),
    placeMaxVisitor: json['placeMaxVisitor'] as int,
    placeName: json['placeName'] as String,
    placePicture: json['placePicture'] as String,
    placePrice: json['placePrice'] as String,
  );
}

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      'placeCategory': instance.placeCategory,
      'placeDescription': instance.placeDescription,
      'placeHourClose': instance.placeHourClose,
      'placeHourOpen': instance.placeHourOpen,
      'placeId': instance.placeId,
      'placeIsOpen': instance.placeIsOpen,
      'placeLatitude': instance.placeLatitude,
      'placeLocation': instance.placeLocation,
      'placeLongitude': instance.placeLongitude,
      'placeMaxVisitor': instance.placeMaxVisitor,
      'placeName': instance.placeName,
      'placePicture': instance.placePicture,
      'placePrice': instance.placePrice,
    };
