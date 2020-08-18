import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileResponse {
  @JsonKey(name: '_id')
  String id;
  String email;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String phone;
  String avatarUrl;
  String shortBio;
  bool emailConfirmed;
  bool phoneConfirmed;
  String confirmSource;
  String subscription;
  DateTime subExpiryDate;
  bool isSubscribed;
  String primaryAddressId;
  int goldCoin;
  int silverCoin;
  bool messageRead;
  bool notifRead;

  ProfileResponse({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.phone,
    this.avatarUrl,
    this.shortBio,
    this.emailConfirmed,
    this.phoneConfirmed,
    this.confirmSource,
    this.subscription,
    this.subExpiryDate,
    this.isSubscribed,
    this.primaryAddressId,
    this.goldCoin,
    this.silverCoin,
    this.messageRead,
    this.notifRead,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
