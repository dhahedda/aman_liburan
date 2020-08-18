// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_image_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatImageModel _$ChatImageModelFromJson(Map<String, dynamic> json) {
  return ChatImageModel(
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
    imgData: json['img_data'] as String,
  );
}

Map<String, dynamic> _$ChatImageModelToJson(ChatImageModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'room_id': instance.roomId,
      'img_data': instance.imgData,
    };
