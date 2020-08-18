import 'package:json_annotation/json_annotation.dart';
import 'package:aman_liburan/models/response/location_response.dart';

part 'items_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ItemsResponse{
  @JsonKey(name: '_id')
  String id;
  String name;
  int price;
  String userId;
  String sellerName;
  String imgUrl;
  LocationResponse location;
  bool isLiked;
  int statusCd;
  String availability;

  ItemsResponse({
    this.id,
    this.name,
    this.price,
    this.userId,
    this.sellerName,
    this.imgUrl,
    this.location,
    this.isLiked,
    this.statusCd,
    this.availability,
  });

  factory ItemsResponse.fromJson(Map<String, dynamic> json) => _$ItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);  
}