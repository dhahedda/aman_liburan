// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) {
  return ItemResponse(
    id: json['_id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    category: json['category'] == null
        ? null
        : CategoriesResponse.fromJson(json['category'] as Map<String, dynamic>),
    categoryIds:
        (json['category_ids'] as List)?.map((e) => e as String)?.toList(),
    images: (json['images'] as List)
        ?.map((e) => e == null
            ? null
            : ImagesResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    userId: json['user_id'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
    location: json['location'] == null
        ? null
        : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
    commentIds:
        (json['comment_ids'] as List)?.map((e) => e as String)?.toList(),
    statusEnum: json['status_enum'] as int,
    availability: json['availability'] as String,
  );
}

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'category_ids': instance.categoryIds,
      'images': instance.images,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'user_id': instance.userId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'location': instance.location,
      'comment_ids': instance.commentIds,
      'status_enum': instance.statusEnum,
      'availability': instance.availability,
    };
