// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seller_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellerResponse _$SellerResponseFromJson(Map<String, dynamic> json) {
  return SellerResponse(
    id: json['_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    goldCoin: json['gold_coin'] as int,
    silverCoin: json['silver_coin'] as int,
    avatarUrl: json['avatar_url'] as String,
    shortBio: json['short_bio'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$SellerResponseToJson(SellerResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'gold_coin': instance.goldCoin,
      'silver_coin': instance.silverCoin,
      'avatar_url': instance.avatarUrl,
      'short_bio': instance.shortBio,
      'created_at': instance.createdAt?.toIso8601String(),
    };
