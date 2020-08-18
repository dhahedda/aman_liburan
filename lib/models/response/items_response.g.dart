// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsResponse _$ItemsResponseFromJson(Map<String, dynamic> json) {
  return ItemsResponse(
    id: json['_id'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    userId: json['user_id'] as String,
    sellerName: json['seller_name'] as String,
    imgUrl: json['img_url'] as String,
    location: json['location'] == null
        ? null
        : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
    isLiked: json['is_liked'] as bool,
    statusCd: json['status_cd'] as int,
    availability: json['availability'] as String,
  );
}

Map<String, dynamic> _$ItemsResponseToJson(ItemsResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'user_id': instance.userId,
      'seller_name': instance.sellerName,
      'img_url': instance.imgUrl,
      'location': instance.location,
      'is_liked': instance.isLiked,
      'status_cd': instance.statusCd,
      'availability': instance.availability,
    };
