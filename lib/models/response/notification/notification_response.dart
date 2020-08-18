import 'package:json_annotation/json_annotation.dart';
import 'package:aman_liburan/models/response/api_response.dart';

part 'notification_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  DateTime createdAt;
  bool isRead;
  String type;
  String status;
  String notifiedId;
  String notifierId;
  NotificationUserResponse notificationUser;
  String appointmentId;
  AppointmentResponse appointment;
  ProductNotification product;

  NotificationResponse({
    this.id,
    this.name,
    this.createdAt,
    this.isRead,
    this.type,
    this.status,
    this.notifiedId,
    this.notifierId,
    this.notificationUser,
    this.appointmentId,
    this.appointment,
    this.product,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
