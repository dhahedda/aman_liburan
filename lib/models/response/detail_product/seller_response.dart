import 'package:json_annotation/json_annotation.dart';

part 'seller_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SellerResponse {
  @JsonKey(name: '_id')
  String id;
  String firstName;
  String lastName;
  int goldCoin;
  int silverCoin;
  String avatarUrl;
  String shortBio;
  DateTime createdAt;

  SellerResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.goldCoin,
    this.silverCoin,
    this.avatarUrl,
    this.shortBio,
    this.createdAt
  });

   factory SellerResponse.fromJson(Map<String, dynamic> json) => _$SellerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SellerResponseToJson(this);
}
