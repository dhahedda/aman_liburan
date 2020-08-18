// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_message_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertMessageParam _$InsertMessageParamFromJson(Map<String, dynamic> json) {
  return InsertMessageParam(
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$InsertMessageParamToJson(InsertMessageParam instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'room_id': instance.roomId,
      'message': instance.message,
    };
