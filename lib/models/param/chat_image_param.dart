import 'package:json_annotation/json_annotation.dart';

part 'chat_image_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatImageModel {
    ChatImageModel({
        this.userId,
        this.roomId,
        this.imgData,
    });

    String userId;
    String roomId;
    String imgData;

  factory ChatImageModel.fromJson(Map<String, dynamic> json) => _$ChatImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatImageModelToJson(this);
}
