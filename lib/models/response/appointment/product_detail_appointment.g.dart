// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailAppointment _$ProductDetailAppointmentFromJson(
    Map<String, dynamic> json) {
  return ProductDetailAppointment(
    id: json['_id'] as String,
    name: json['name'] as String,
    price: json['price'] as int,
    userId: json['user_id'] as String,
    sellerName: json['seller_name'] as String,
    imgUrl: json['img_url'] as String,
    location: json['location'] == null
        ? null
        : LocationResponse.fromJson(json['location'] as Map<String, dynamic>),
    statusEnum: json['status_enum'] as int,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$ProductDetailAppointmentToJson(
        ProductDetailAppointment instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'user_id': instance.userId,
      'seller_name': instance.sellerName,
      'img_url': instance.imgUrl,
      'location': instance.location,
      'status_enum': instance.statusEnum,
      'status': instance.status,
    };
