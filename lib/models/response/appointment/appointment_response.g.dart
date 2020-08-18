// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentResponse _$AppointmentResponseFromJson(Map<String, dynamic> json) {
  return AppointmentResponse(
    id: json['_id'] as String,
    status: json['status'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    expiresAt: json['expires_at'] == null
        ? null
        : DateTime.parse(json['expires_at'] as String),
    isDelivery: json['is_delivery'] as bool,
    meetingTime: json['meeting_time'] == null
        ? null
        : DateTime.parse(json['meeting_time'] as String),
    productId: json['product_id'] as String,
    productDetail: json['product_detail'] == null
        ? null
        : ProductDetailAppointment.fromJson(
            json['product_detail'] as Map<String, dynamic>),
    sellerId: json['seller_id'] as String,
    appointmentUser: json['appointment_user'] == null
        ? null
        : AppointmentUser.fromJson(
            json['appointment_user'] as Map<String, dynamic>),
    requesterId: json['requester_id'] as String,
  );
}

Map<String, dynamic> _$AppointmentResponseToJson(
        AppointmentResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'is_delivery': instance.isDelivery,
      'meeting_time': instance.meetingTime?.toIso8601String(),
      'product_id': instance.productId,
      'product_detail': instance.productDetail,
      'seller_id': instance.sellerId,
      'appointment_user': instance.appointmentUser,
      'requester_id': instance.requesterId,
    };
