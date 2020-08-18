import 'package:json_annotation/json_annotation.dart';

part 'chat_lobby_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ChatLobbyResponse {
  @JsonKey(name: '_id')
  String id;
  String name;
  List<String> userIds;
  DateTime lastActive;
  bool isRead;
  String iconUrl;
  String lastMessage;

  ChatLobbyResponse({
    this.id,
    this.name,
    this.userIds,
    this.lastActive,
    this.isRead,
    this.iconUrl,
    this.lastMessage,
  });

  factory ChatLobbyResponse.fromJson(Map<String, dynamic> json) => _$ChatLobbyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatLobbyResponseToJson(this);
}
