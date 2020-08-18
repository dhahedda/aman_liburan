// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomMessageResponse _$RoomMessageResponseFromJson(Map<String, dynamic> json) {
  return RoomMessageResponse(
    id: json['_id'] as String,
    message: json['message'] as String,
    image: json['image'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
    readerIds: (json['reader_ids'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$RoomMessageResponseToJson(
        RoomMessageResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'message': instance.message,
      'image': instance.image,
      'created_at': instance.createdAt?.toIso8601String(),
      'user_id': instance.userId,
      'room_id': instance.roomId,
      'reader_ids': instance.readerIds,
    };
