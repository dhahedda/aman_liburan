// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketMessageResponse _$WebSocketMessageResponseFromJson(
    Map<String, dynamic> json) {
  return WebSocketMessageResponse(
    roomMessage: json['room_message'] == null
        ? null
        : RoomMessage.fromJson(json['room_message'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WebSocketMessageResponseToJson(
        WebSocketMessageResponse instance) =>
    <String, dynamic>{
      'room_message': instance.roomMessage,
    };

RoomMessage _$RoomMessageFromJson(Map<String, dynamic> json) {
  return RoomMessage(
    id: json['_id'] as String,
    message: json['message'] as String,
    image: json['image'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
  );
}

Map<String, dynamic> _$RoomMessageToJson(RoomMessage instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'image': instance.image,
      'created_at': instance.createdAt?.toIso8601String(),
      'user_id': instance.userId,
      'room_id': instance.roomId,
    };
