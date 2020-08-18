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
    dateOfBirth: json['date_of_birth'] == null
        ? null
        : DateTime.parse(json['date_of_birth'] as String),
    phone: json['phone'] as String,
    wechat: json['wechat'] as String,
    avatarUrl: json['avatar_url'] as String,
    shortBio: json['short_bio'] as String,
    authenticationToken: json['authentication_token'] as String,
    refreshToken: json['refresh_token'] as String,
    emailConfirmed: json['email_confirmed'] as bool,
    phoneConfirmed: json['phone_confirmed'] as bool,
    confirmSource: json['confirm_source'] as String,
    phoneConfirmExpiry: json['phone_confirm_expiry'] == null
        ? null
        : DateTime.parse(json['phone_confirm_expiry'] as String),
    subscription: json['subscription'] as String,
    subsExpiryDate: json['subs_expiry_date'] == null
        ? null
        : DateTime.parse(json['subs_expiry_date'] as String),
    isSubscribed: json['is_subscribed'] as bool,
    followedProductIds: (json['followed_product_ids'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    primaryAddressId: json['primary_address_id'] as String,
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    resetTokenExpiry: json['reset_token_expiry'] == null
        ? null
        : DateTime.parse(json['reset_token_expiry'] as String),
    messageRead: json['message_read'] as bool,
    notifRead: json['notif_read'] as bool,
    authTokenExpiry: json['auth_token_expiry'] == null
        ? null
        : DateTime.parse(json['auth_token_expiry'] as String),
    refreshTokenExpiry: json['refresh_token_expiry'] == null
        ? null
        : DateTime.parse(json['refresh_token_expiry'] as String),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'phone': instance.phone,
      'wechat': instance.wechat,
      'avatar_url': instance.avatarUrl,
      'short_bio': instance.shortBio,
      'authentication_token': instance.authenticationToken,
      'refresh_token': instance.refreshToken,
      'email_confirmed': instance.emailConfirmed,
      'phone_confirmed': instance.phoneConfirmed,
      'confirm_source': instance.confirmSource,
      'phone_confirm_expiry': instance.phoneConfirmExpiry?.toIso8601String(),
      'subscription': instance.subscription,
      'subs_expiry_date': instance.subsExpiryDate?.toIso8601String(),
      'is_subscribed': instance.isSubscribed,
      'followed_product_ids': instance.followedProductIds,
      'primary_address_id': instance.primaryAddressId,
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'reset_token_expiry': instance.resetTokenExpiry?.toIso8601String(),
      'message_read': instance.messageRead,
      'notif_read': instance.notifRead,
      'auth_token_expiry': instance.authTokenExpiry?.toIso8601String(),
      'refresh_token_expiry': instance.refreshTokenExpiry?.toIso8601String(),
    };
