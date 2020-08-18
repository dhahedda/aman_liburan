// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchParam _$SearchParamFromJson(Map<String, dynamic> json) {
  return SearchParam(
    query: json['query'] as String,
    category: json['category'] as String,
    sortBy: json['sort_by'] as String,
    status: json['status'] as String,
    priceMin: json['price_min'] as int,
    priceMax: json['price_max'] as int,
    userId: json['user_id'] as String,
    start: json['start'] as int,
    limit: json['limit'] as int,
  );
}

Map<String, dynamic> _$SearchParamToJson(SearchParam instance) =>
    <String, dynamic>{
      'query': instance.query,
      'category': instance.category,
      'sort_by': instance.sortBy,
      'status': instance.status,
      'price_min': instance.priceMin,
      'price_max': instance.priceMax,
      'user_id': instance.userId,
      'start': instance.start,
      'limit': instance.limit,
    };
