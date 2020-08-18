// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalResponse _$GlobalResponseFromJson(Map<String, dynamic> json) {
  return GlobalResponse(
    status: json['status'] as String,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : DataResponse.fromJson(json['data'] as Map<String, dynamic>),
  )..error = json['error'] as String;
}

Map<String, dynamic> _$GlobalResponseToJson(GlobalResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
