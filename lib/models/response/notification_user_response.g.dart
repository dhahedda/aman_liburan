// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationUserResponse _$NotificationUserResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationUserResponse(
    id: json['_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    avatarUrl: json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$NotificationUserResponseToJson(
        NotificationUserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'avatar_url': instance.avatarUrl,
    };
