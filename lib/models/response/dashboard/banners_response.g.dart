// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banners_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannersResponse _$BannersResponseFromJson(Map<String, dynamic> json) {
  return BannersResponse(
    id: json['_id'] as String,
    imgUrl: json['img_url'] as String,
    bannerUrl: json['banner_url'] as String,
  );
}

Map<String, dynamic> _$BannersResponseToJson(BannersResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'img_url': instance.imgUrl,
      'banner_url': instance.bannerUrl,
    };
