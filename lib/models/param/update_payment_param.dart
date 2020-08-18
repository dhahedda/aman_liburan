import 'package:json_annotation/json_annotation.dart';

part 'update_payment_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePaymentParam {
  String paypal;
  String wechat;
  String bankAccountName;
  String bankAccountNumber;
  String bankName;
  bool cod;
  
  UpdatePaymentParam({
      this.paypal,
      this.wechat,
      this.bankAccountName,
      this.bankAccountNumber,
      this.bankName,
      this.cod,
  });

  factory UpdatePaymentParam.fromJson(Map<String, dynamic> json) => _$UpdatePaymentParamFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePaymentParamToJson(this);
}
