import 'package:json_annotation/json_annotation.dart';

part 'payment_method_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentMethodResponse {
  @JsonKey(name: '_id')
  String id;
  String wechat;
  bool cod;
  String paypal;
  String bankAccountNumber;
  String bankAccountName;
  String bankName;
  String userId;

  PaymentMethodResponse({
      this.id,
      this.wechat,
      this.cod,
      this.paypal,
      this.bankAccountNumber,
      this.bankAccountName,
      this.bankName,
      this.userId,
  });

  
  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) => _$PaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodResponseToJson(this);
}