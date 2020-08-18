// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailItemResponse _$DetailItemResponseFromJson(Map<String, dynamic> json) {
  return DetailItemResponse(
    id: json['_id'] as String,
    productId: json['product_id'] as String,
    brand: json['brand'] as String,
    condition: json['condition'] as String,
    yearsOwned: json['years_owned'] as String,
    modelName: json['model_name'] as String,
  );
}

Map<String, dynamic> _$DetailItemResponseToJson(DetailItemResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'product_id': instance.productId,
      'brand': instance.brand,
      'condition': instance.condition,
      'years_owned': instance.yearsOwned,
      'model_name': instance.modelName,
    };
