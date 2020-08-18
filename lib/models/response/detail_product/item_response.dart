import 'package:aman_liburan/models/response/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  String description;
  int price;
  CategoriesResponse category;
  List<String> categoryIds;
  List<ImagesResponse> images;
  DateTime createdAt;
  DateTime updatedAt;
  String userId;
  double latitude;
  double longitude;
  LocationResponse location;
  List<String> commentIds;
  int statusEnum;
  String availability;
  
  ItemResponse({
    this.id,
    this.name,
    this.description,
    this.price,
    this.category,
    this.categoryIds,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.latitude,
    this.longitude,
    this.location,
    this.commentIds,
    this.statusEnum,
    this.availability,
  });

  factory ItemResponse.fromJson(Map<String, dynamic> json) => _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}
