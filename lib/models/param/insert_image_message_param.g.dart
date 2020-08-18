// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insert_image_message_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertImageMessageParam _$InsertImageMessageParamFromJson(
    Map<String, dynamic> json) {
  return InsertImageMessageParam(
    userId: json['user_id'] as String,
    roomId: json['room_id'] as String,
    imgData: json['img_data'] as String,
  );
}

Map<String, dynamic> _$InsertImageMessageParamToJson(
        InsertImageMessageParam instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'room_id': instance.roomId,
      'img_data': instance.imgData,
    };
