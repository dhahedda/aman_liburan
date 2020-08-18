import 'package:json_annotation/json_annotation.dart';

part 'detail_item_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DetailItemResponse {
  @JsonKey(name: '_id')
  String id;
  String productId;
  String brand;
  String condition;
  String yearsOwned;
  String modelName;

  DetailItemResponse({
    this.id,
    this.productId,
    this.brand,
    this.condition,
    this.yearsOwned,
    this.modelName,
  });

  factory DetailItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailItemResponseToJson(this);
}
