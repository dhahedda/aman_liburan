import 'package:json_annotation/json_annotation.dart';

part 'notification_user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NotificationUserResponse {
  @JsonKey(name: '_id')
  String id;
  String firstName;
  String lastName;
  int goldCoin;
  int silverCoin;
  String avatarUrl;

  NotificationUserResponse({
      this.id,
      this.firstName,
      this.lastName,
      this.goldCoin,
      this.silverCoin,
      this.avatarUrl,
  });

  factory NotificationUserResponse.fromJson(Map<String, dynamic> json) => _$NotificationUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationUserResponseToJson(this);
}