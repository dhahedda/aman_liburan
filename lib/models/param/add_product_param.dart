import 'package:json_annotation/json_annotation.dart';

part 'add_product_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddProductParam {
    AddProductParam({
        this.product,
        this.productDetail,
        this.productImages,
    });

    ProductWithoutId product;
    ProductDetail productDetail;
    List<ProductImage> productImages;

  factory AddProductParam.fromJson(Map<String, dynamic> json) => _$AddProductParamFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductParamToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductWithoutId {
    ProductWithoutId({
        this.name,
        this.price,
        this.description,
        this.categoryIds,
        this.latitude,
        this.longitude,
    });

    String name;
    int price;
    String description;
    List<String> categoryIds;
    double latitude;
    double longitude;

  factory ProductWithoutId.fromJson(Map<String, dynamic> json) => _$ProductWithoutIdFromJson(json);

  Map<String, dynamic> toJson() => _$ProductWithoutIdToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductDetail {
    ProductDetail({
        this.brand,
        this.condition,
        this.yearsOwned,
        this.modelName,
    });

    String brand;
    String condition;
    String yearsOwned;
    String modelName;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => _$ProductDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductImage {
    ProductImage({
        this.thumbData,
        this.imageData,
    });

    String thumbData;
    String imageData;

  factory ProductImage.fromJson(Map<String, dynamic> json) => _$ProductImageFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageToJson(this);
}
