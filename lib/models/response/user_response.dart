import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserResponse {
  UserResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.phone,
    this.wechat,
    this.avatarUrl,
    this.shortBio,
    this.authenticationToken,
    this.refreshToken,
    this.emailConfirmed,
    this.phoneConfirmed,
    this.confirmSource,
    this.phoneConfirmExpiry,
    this.subscription,
    this.subsExpiryDate,
    this.isSubscribed,
    this.followedProductIds,
    this.primaryAddressId,
    this.goldCoin,
    this.silverCoin,
    this.resetTokenExpiry,
    this.messageRead,
    this.notifRead,
    this.authTokenExpiry,
    this.refreshTokenExpiry,
  });

  @JsonKey(name: '_id')
  String id;
  String email;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String phone;
  String wechat;
  String avatarUrl;
  String shortBio;
  String authenticationToken;
  String refreshToken;
  bool emailConfirmed;
  bool phoneConfirmed;
  String confirmSource;
  DateTime phoneConfirmExpiry;
  String subscription;
  DateTime subsExpiryDate;
  bool isSubscribed;
  List<String> followedProductIds;
  String primaryAddressId;
  int goldCoin;
  int silverCoin;
  DateTime resetTokenExpiry;
  bool messageRead;
  bool notifRead;
  DateTime authTokenExpiry;
  DateTime refreshTokenExpiry;

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
