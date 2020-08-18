import 'package:json_annotation/json_annotation.dart';

part 'appointment_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppointmentUser {
  @JsonKey(name: '_id')
  String id;
  String firstName;
  String lastName;
  int goldCoin;
  int silverCoin;
  String avatarUrl;

  AppointmentUser({
    this.id,
    this.firstName,
    this.lastName,
    this.goldCoin,
    this.silverCoin,
    this.avatarUrl,
  });

  factory AppointmentUser.fromJson(Map<String, dynamic> json) => _$AppointmentUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentUserToJson(this);
}
