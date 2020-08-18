import 'package:json_annotation/json_annotation.dart';

part 'payment_credit_card_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentCreditCardParam {
  int amount;
  String currency;
  String token;
  
  PaymentCreditCardParam({
      this.amount,
      this.currency,
      this.token,
  });

  factory PaymentCreditCardParam.fromJson(Map<String, dynamic> json) => _$PaymentCreditCardParamFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCreditCardParamToJson(this);
}