import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  @JsonKey(name: '_id')
  String id;
  String email;
  String firstName;
  String lastName;
  String phone;
  String wechat;
  String avatarUrl;
  String authenticationToken;
  String refreshToken;
  List<String> followedProductIds;
  String primaryAddressId;
  DateTime resetTokenExpiry;

  UserResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.wechat,
    this.avatarUrl,
    this.authenticationToken,
    this.refreshToken,
    this.followedProductIds,
    this.primaryAddressId,
    this.resetTokenExpiry,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
