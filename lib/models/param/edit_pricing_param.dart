import 'package:json_annotation/json_annotation.dart';

part 'edit_pricing_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EditPricingParam {
  EditPricingParam({
    this.id,
    this.price,
  });

  @JsonKey(name: '_id')
  String id;
  int price;

  factory EditPricingParam.fromJson(Map<String, dynamic> json) => _$EditPricingParamFromJson(json);

  Map<String, dynamic> toJson() => _$EditPricingParamToJson(this);
}
