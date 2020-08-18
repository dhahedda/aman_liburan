import 'package:json_annotation/json_annotation.dart';

part 'payment_konbini_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PaymentKonbiniParam {
  int amount;
  String currency;
  String sourceId;
  
  PaymentKonbiniParam({
      this.amount,
      this.currency,
      this.sourceId,
  });

  factory PaymentKonbiniParam.fromJson(Map<String, dynamic> json) => _$PaymentKonbiniParamFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentKonbiniParamToJson(this);
}