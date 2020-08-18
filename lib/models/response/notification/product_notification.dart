import 'package:json_annotation/json_annotation.dart';
import 'package:aman_liburan/models/response/api_response.dart';

part 'product_notification.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductNotification {
  @JsonKey(name: '_id')
  String id;
  String name;
  int price;
  String userId;
  String sellerName;
  String imgUrl;
  LocationResponse location;
  int statusEnum;
  String status;

  ProductNotification({
    this.id,
    this.name,
    this.price,
    this.userId,
    this.sellerName,
    this.imgUrl,
    this.location,
    this.statusEnum,
    this.status,
  });

  factory ProductNotification.fromJson(Map<String, dynamic> json) =>
      _$ProductNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ProductNotificationToJson(this);
}
