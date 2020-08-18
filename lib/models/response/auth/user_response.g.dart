// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    id: json['_id'] as String,
    email: json['email'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    phone: json['phone'] as String,
    wechat: json['wechat'] as String,
    avatarUrl: json['avatar_url'] as String,
    authenticationToken: json['authentication_token'] as String,
    refreshToken: json['refresh_token'] as String,
    followedProductIds: (json['followed_product_ids'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    primaryAddressId: json['primary_address_id'] as String,
    resetTokenExpiry: json['reset_token_expiry'] == null
        ? null
        : DateTime.parse(json['reset_token_expiry'] as String),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'wechat': instance.wechat,
      'avatar_url': instance.avatarUrl,
      'authentication_token': instance.authenticationToken,
      'refresh_token': instance.refreshToken,
      'followed_product_ids': instance.followedProductIds,
      'primary_address_id': instance.primaryAddressId,
      'reset_token_expiry': instance.resetTokenExpiry?.toIso8601String(),
    };
