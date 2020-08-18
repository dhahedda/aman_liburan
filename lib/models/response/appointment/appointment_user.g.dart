// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentUser _$AppointmentUserFromJson(Map<String, dynamic> json) {
  return AppointmentUser(
    id: json['_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$AppointmentUserToJson(AppointmentUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'avatar_url': instance.avatarUrl,
    };
