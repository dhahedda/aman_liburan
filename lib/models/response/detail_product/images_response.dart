import 'package:json_annotation/json_annotation.dart';

part 'images_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ImagesResponse {
  @JsonKey(name: '_id')
  String id;
  String imgUrl;

  ImagesResponse({
      this.id,
      this.imgUrl,
  });

  factory ImagesResponse.fromJson(Map<String, dynamic> json) => _$ImagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesResponseToJson(this);
}