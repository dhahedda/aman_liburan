import 'package:json_annotation/json_annotation.dart';
import 'package:aman_liburan/models/response/api_response.dart';

part 'appointment_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppointmentResponse {
  @JsonKey(name: '_id')
  String id;
    String status;
    DateTime createdAt;
    DateTime expiresAt;
    bool isDelivery;
    DateTime meetingTime;
    String productId;
    ProductDetailAppointment productDetail;
    String sellerId;
    AppointmentUser appointmentUser;
    String requesterId;

    AppointmentResponse({
        this.id,
        this.status,
        this.createdAt,
        this.expiresAt,
        this.isDelivery,
        this.meetingTime,
        this.productId,
        this.productDetail,
        this.sellerId,
        this.appointmentUser,
        this.requesterId,
    });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) => _$AppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentResponseToJson(this);
}
