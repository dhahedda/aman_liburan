// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagesResponse _$ImagesResponseFromJson(Map<String, dynamic> json) {
  return ImagesResponse(
    id: json['_id'] as String,
    imgUrl: json['img_url'] as String,
  );
}

Map<String, dynamic> _$ImagesResponseToJson(ImagesResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'img_url': instance.imgUrl,
    };
