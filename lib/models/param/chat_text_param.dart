import 'package:json_annotation/json_annotation.dart';

part 'chat_text_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatTextParam {
    ChatTextParam({
        this.userId,
        this.roomId,
        this.message,
    });

    String userId;
    String roomId;
    String message;

  factory ChatTextParam.fromJson(Map<String, dynamic> json) => _$ChatTextParamFromJson(json);

  Map<String, dynamic> toJson() => _$ChatTextParamToJson(this);
}
