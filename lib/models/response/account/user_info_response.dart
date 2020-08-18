import 'package:json_annotation/json_annotation.dart';

part 'user_info_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserInfoResponse {
  UserInfoResponse({
    @JsonKey(name: '_id')
    this.id,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.goldCoin,
    this.silverCoin,
    this.avatarUrl,
    this.shortBio,
  });

  String id;
  String firstName;
  String lastName;
  DateTime createdAt;
  int goldCoin;
  int silverCoin;
  String avatarUrl;
  String shortBio;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}
