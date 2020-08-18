import 'package:aman_liburan/models/response/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_appointment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductDetailAppointment {
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

  ProductDetailAppointment({
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

   factory ProductDetailAppointment.fromJson(Map<String, dynamic> json) => _$ProductDetailAppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailAppointmentToJson(this);
}
