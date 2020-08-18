import 'package:json_annotation/json_annotation.dart';

part 'categories_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CategoriesResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String displayName;
  String iconUrl;
  List<CategoriesResponse> children;
  String parentId;
  String error;
  int depth;

  CategoriesResponse(
      {this.id,
      this.name,
      this.displayName,
      this.iconUrl,
      this.parentId,
      this.children,
      this.depth});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);

  CategoriesResponse.withError(String errorValue) : error = errorValue;
}
