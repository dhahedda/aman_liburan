import 'package:json_annotation/json_annotation.dart';

part 'insert_message_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InsertMessageParam {
    String userId;
    String roomId;
    String message;

    InsertMessageParam({
        this.userId,
        this.roomId,
        this.message,
    });

  factory InsertMessageParam.fromJson(Map<String, dynamic> json) => _$InsertMessageParamFromJson(json);

  Map<String, dynamic> toJson() => _$InsertMessageParamToJson(this);
}
