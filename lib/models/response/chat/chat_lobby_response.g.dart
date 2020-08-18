// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_lobby_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatLobbyResponse _$ChatLobbyResponseFromJson(Map<String, dynamic> json) {
  return ChatLobbyResponse(
    id: json['_id'] as String,
    name: json['name'] as String,
    userIds: (json['user_ids'] as List)?.map((e) => e as String)?.toList(),
    lastActive: json['last_active'] == null
        ? null
        : DateTime.parse(json['last_active'] as String),
    isRead: json['is_read'] as bool,
    iconUrl: json['icon_url'] as String,
    lastMessage: json['last_message'] as String,
  );
}

Map<String, dynamic> _$ChatLobbyResponseToJson(ChatLobbyResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'user_ids': instance.userIds,
      'last_active': instance.lastActive?.toIso8601String(),
      'is_read': instance.isRead,
      'icon_url': instance.iconUrl,
      'last_message': instance.lastMessage,
    };
