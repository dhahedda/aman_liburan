import 'package:json_annotation/json_annotation.dart';

part 'mark_as_sold_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MarkAsSoldParam {
  MarkAsSoldParam({
    this.id,
  });

  @JsonKey(name: '_id')
  String id;

  factory MarkAsSoldParam.fromJson(Map<String, dynamic> json) => _$MarkAsSoldParamFromJson(json);

  Map<String, dynamic> toJson() => _$MarkAsSoldParamToJson(this);
}
