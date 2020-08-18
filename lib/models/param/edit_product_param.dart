import 'package:json_annotation/json_annotation.dart';
import 'package:aman_liburan/models/param/add_product_param.dart';

part 'edit_product_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EditProductParam {
  EditProductParam({
    this.product,
    this.productDetail,
  });

  Product product;
  ProductDetail productDetail;

  factory EditProductParam.fromJson(Map<String, dynamic> json) => _$EditProductParamFromJson(json);

  Map<String, dynamic> toJson() => _$EditProductParamToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.categoryIds,
    this.latitude,
    this.longitude,
  });

  @JsonKey(name: '_id')
  String id;
  String name;
  int price;
  String description;
  List<String> categoryIds;
  double latitude;
  double longitude;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
