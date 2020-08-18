import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenResponse {
  @JsonKey(name: '_id')
  String id;
  String userId;
  String authToken;
  DateTime authTokenExpiry;
  String authTokenUuid;
  String refreshToken;
  DateTime refreshTokenExpiry;
  String refreshTokenUuid;

  TokenResponse({
    this.id,
    this.userId,
    this.authToken,
    this.authTokenExpiry,
    this.authTokenUuid,
    this.refreshToken,
    this.refreshTokenExpiry,
    this.refreshTokenUuid,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
