// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_product_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditProductParam _$EditProductParamFromJson(Map<String, dynamic> json) {
  return EditProductParam(
    product: json['product'] == null
        ? null
        : Product.fromJson(json['product'] as Map<String, dynamic>),
    productDetail: json['product_detail'] == null
        ? null
        : ProductDetail.fromJson(
            json['product_detail'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$EditProductParamToJson(EditProductParam instance) =>
    <String, dynamic>{
      'product': instance.product,
      'product_detail': instance.productDetail,
    };

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['_id'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    description: json['description'] as String,
    categoryIds:
        (json['category_ids'] as List)?.map((e) => e as String)?.toList(),
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'category_ids': instance.categoryIds,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
