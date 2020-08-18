// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) {
  return UserInfoResponse(
    id: json['id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    avatarUrl: json['avatar_url'] as String,
    shortBio: json['short_bio'] as String,
  );
}

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'created_at': instance.createdAt?.toIso8601String(),
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'avatar_url': instance.avatarUrl,
      'short_bio': instance.shortBio,
    };
