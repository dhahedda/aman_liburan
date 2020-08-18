// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductParam _$AddProductParamFromJson(Map<String, dynamic> json) {
  return AddProductParam(
    product: json['product'] == null
        ? null
        : ProductWithoutId.fromJson(json['product'] as Map<String, dynamic>),
    productDetail: json['product_detail'] == null
        ? null
        : ProductDetail.fromJson(
            json['product_detail'] as Map<String, dynamic>),
    productImages: (json['product_images'] as List)
        ?.map((e) =>
            e == null ? null : ProductImage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddProductParamToJson(AddProductParam instance) =>
    <String, dynamic>{
      'product': instance.product,
      'product_detail': instance.productDetail,
      'product_images': instance.productImages,
    };

ProductWithoutId _$ProductWithoutIdFromJson(Map<String, dynamic> json) {
  return ProductWithoutId(
    name: json['name'] as String,
    price: json['price'] as int,
    description: json['description'] as String,
    categoryIds:
        (json['category_ids'] as List)?.map((e) => e as String)?.toList(),
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ProductWithoutIdToJson(ProductWithoutId instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'category_ids': instance.categoryIds,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

ProductDetail _$ProductDetailFromJson(Map<String, dynamic> json) {
  return ProductDetail(
    brand: json['brand'] as String,
    condition: json['condition'] as String,
    yearsOwned: json['years_owned'] as String,
    modelName: json['model_name'] as String,
  );
}

Map<String, dynamic> _$ProductDetailToJson(ProductDetail instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'condition': instance.condition,
      'years_owned': instance.yearsOwned,
      'model_name': instance.modelName,
    };

ProductImage _$ProductImageFromJson(Map<String, dynamic> json) {
  return ProductImage(
    thumbData: json['thumb_data'] as String,
    imageData: json['image_data'] as String,
  );
}

Map<String, dynamic> _$ProductImageToJson(ProductImage instance) =>
    <String, dynamic>{
      'thumb_data': instance.thumbData,
      'image_data': instance.imageData,
    };
