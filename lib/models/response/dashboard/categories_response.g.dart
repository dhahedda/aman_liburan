// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) {
  return CategoriesResponse(
    id: json['_id'] as String,
    name: json['name'] as String,
    displayName: json['display_name'] as String,
    iconUrl: json['icon_url'] as String,
    parentId: json['parent_id'] as String,
    children: (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : CategoriesResponse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    depth: json['depth'] as int,
  )..error = json['error'] as String;
}

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'display_name': instance.displayName,
      'icon_url': instance.iconUrl,
      'children': instance.children,
      'parent_id': instance.parentId,
      'error': instance.error,
      'depth': instance.depth,
    };
