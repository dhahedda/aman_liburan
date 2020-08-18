import 'package:json_annotation/json_annotation.dart';

part 'insert_image_message_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InsertImageMessageParam {
    InsertImageMessageParam({
        this.userId,
        this.roomId,
        this.imgData,
    });

    String userId;
    String roomId;
    String imgData;

  factory InsertImageMessageParam.fromJson(Map<String, dynamic> json) => _$InsertImageMessageParamFromJson(json);

  Map<String, dynamic> toJson() => _$InsertImageMessageParamToJson(this);
}
