import 'package:json_annotation/json_annotation.dart';

part 'websocket_message_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WebSocketMessageResponse {
  RoomMessage roomMessage;

  WebSocketMessageResponse({
    this.roomMessage,
  });

  factory WebSocketMessageResponse.fromJson(Map<String, dynamic> json) => _$WebSocketMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketMessageResponseToJson(this);

  String toString() => '''
  {
    "room_message": {
      "_id": "${roomMessage.id}",
      "message": "${roomMessage.message}",
      "image": "${roomMessage.image}",
      "created_at": "${DateTime.now()}",
      "user_id": "${roomMessage.userId}",
      "room_id": "${roomMessage.roomId}"
    }
  }
  ''';
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RoomMessage {
  @JsonKey(name: '_id')
  String id;
  String message;
  String image;
  DateTime createdAt;
  String userId;
  String roomId;

  RoomMessage({
    this.id,
    this.message,
    this.image,
    this.createdAt,
    this.userId,
    this.roomId,
  });

  factory RoomMessage.fromJson(Map<String, dynamic> json) => _$RoomMessageFromJson(json);

  Map<String, dynamic> toJson() => _$RoomMessageToJson(this);
}
