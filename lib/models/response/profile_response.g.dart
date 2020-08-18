// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return ProfileResponse(
    id: json['_id'] as String,
    email: json['email'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    dateOfBirth: json['date_of_birth'] == null
        ? null
        : DateTime.parse(json['date_of_birth'] as String),
    phone: json['phone'] as String,
    avatarUrl: json['avatar_url'] as String,
    shortBio: json['short_bio'] as String,
    emailConfirmed: json['email_confirmed'] as bool,
    phoneConfirmed: json['phone_confirmed'] as bool,
    confirmSource: json['confirm_source'] as String,
    subscription: json['subscription'] as String,
    subExpiryDate: json['sub_expiry_date'] == null
        ? null
        : DateTime.parse(json['sub_expiry_date'] as String),
    isSubscribed: json['is_subscribed'] as bool,
    primaryAddressId: json['primary_address_id'] as String,
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    messageRead: json['message_read'] as bool,
    notifRead: json['notif_read'] as bool,
  );
}

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'phone': instance.phone,
      'avatar_url': instance.avatarUrl,
      'short_bio': instance.shortBio,
      'email_confirmed': instance.emailConfirmed,
      'phone_confirmed': instance.phoneConfirmed,
      'confirm_source': instance.confirmSource,
      'subscription': instance.subscription,
      'sub_expiry_date': instance.subExpiryDate?.toIso8601String(),
      'is_subscribed': instance.isSubscribed,
      'primary_address_id': instance.primaryAddressId,
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'message_read': instance.messageRead,
      'notif_read': instance.notifRead,
    };
