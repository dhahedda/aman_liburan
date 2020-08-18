import 'package:json_annotation/json_annotation.dart';

part 'room_message_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RoomMessageResponse {
  @JsonKey(name: '_id')
  String id;
  String message;
  String image;
  DateTime createdAt;
  String userId;
  String roomId;
  List<String> readerIds;

  RoomMessageResponse({
    this.id,
    this.message,
    this.image,
    this.createdAt,
    this.userId,
    this.roomId,
    this.readerIds,
  });

  factory RoomMessageResponse.fromJson(Map<String, dynamic> json) => _$RoomMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoomMessageResponseToJson(this);
}
