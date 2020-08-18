// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_payment_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePaymentParam _$UpdatePaymentParamFromJson(Map<String, dynamic> json) {
  return UpdatePaymentParam(
    paypal: json['paypal'] as String,
    wechat: json['wechat'] as String,
    bankAccountName: json['bank_account_name'] as String,
    bankAccountNumber: json['bank_account_number'] as String,
    bankName: json['bank_name'] as String,
    cod: json['cod'] as bool,
  );
}

Map<String, dynamic> _$UpdatePaymentParamToJson(UpdatePaymentParam instance) =>
    <String, dynamic>{
      'paypal': instance.paypal,
      'wechat': instance.wechat,
      'bank_account_name': instance.bankAccountName,
      'bank_account_number': instance.bankAccountNumber,
      'bank_name': instance.bankName,
      'cod': instance.cod,
    };
