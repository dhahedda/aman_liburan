// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_text_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatTextParam _$ChatTextParamFromJson(Map<String, dynamic> json) {
  return ChatTextParam(
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ChatTextParamToJson(ChatTextParam instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'room_id': instance.roomId,
      'message': instance.message,
    };
