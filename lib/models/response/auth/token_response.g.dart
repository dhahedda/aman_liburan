// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) {
  return TokenResponse(
    id: json['_id'] as String,
    userId: json['user_id'] as String,
    authToken: json['auth_token'] as String,
    authTokenExpiry: json['auth_token_expiry'] == null
        ? null
        : DateTime.parse(json['auth_token_expiry'] as String),
    authTokenUuid: json['auth_token_uuid'] as String,
    refreshToken: json['refresh_token'] as String,
    refreshTokenExpiry: json['refresh_token_expiry'] == null
        ? null
        : DateTime.parse(json['refresh_token_expiry'] as String),
    refreshTokenUuid: json['refresh_token_uuid'] as String,
  );
}

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.userId,
      'auth_token': instance.authToken,
      'auth_token_expiry': instance.authTokenExpiry?.toIso8601String(),
      'auth_token_uuid': instance.authTokenUuid,
      'refresh_token': instance.refreshToken,
      'refresh_token_expiry': instance.refreshTokenExpiry?.toIso8601String(),
      'refresh_token_uuid': instance.refreshTokenUuid,
    };
