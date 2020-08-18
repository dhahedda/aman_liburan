import 'package:json_annotation/json_annotation.dart';

part 'banners_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BannersResponse{
  @JsonKey(name: '_id')
  String id;
  String imgUrl;
  String bannerUrl;

  BannersResponse({
      this.id,
      this.imgUrl,
      this.bannerUrl,
  });

  factory BannersResponse.fromJson(Map<String, dynamic> json) => _$BannersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannersResponseToJson(this);
}