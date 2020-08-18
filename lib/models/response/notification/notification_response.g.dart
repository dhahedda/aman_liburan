// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return NotificationResponse(
    id: json['_id'] as String,
    name: json['name'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    isRead: json['is_read'] as bool,
    type: json['type'] as String,
    status: json['status'] as String,
    notifiedId: json['notified_id'] as String,
    notifierId: json['notifier_id'] as String,
    notificationUser: json['notification_user'] == null
        ? null
        : NotificationUserResponse.fromJson(
            json['notification_user'] as Map<String, dynamic>),
    appointmentId: json['appointment_id'] as String,
    appointment: json['appointment'] == null
        ? null
        : AppointmentResponse.fromJson(
            json['appointment'] as Map<String, dynamic>),
    product: json['product'] == null
        ? null
        : ProductNotification.fromJson(json['product'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt?.toIso8601String(),
      'is_read': instance.isRead,
      'type': instance.type,
      'status': instance.status,
      'notified_id': instance.notifiedId,
      'notifier_id': instance.notifierId,
      'notification_user': instance.notificationUser,
      'appointment_id': instance.appointmentId,
      'appointment': instance.appointment,
      'product': instance.product,
    };
