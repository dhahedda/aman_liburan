import 'package:json_annotation/json_annotation.dart';

part 'search_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchParam {
    SearchParam({
        this.query,
        this.category,
        this.sortBy,
        this.status,
        this.priceMin,
        this.priceMax,
        this.userId,
        this.start,
        this.limit,
    });

    String query;
    String category;
    String sortBy;
    String status;
    int priceMin;
    int priceMax;
    String userId;
    int start;
    int limit;

  factory SearchParam.fromJson(Map<String, dynamic> json) => _$SearchParamFromJson(json);

  Map<String, dynamic> toJson() => _$SearchParamToJson(this);
}
