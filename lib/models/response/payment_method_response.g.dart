// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentMethodResponse _$PaymentMethodResponseFromJson(
    Map<String, dynamic> json) {
  return PaymentMethodResponse(
    id: json['_id'] as String,
    wechat: json['wechat'] as String,
    cod: json['cod'] as bool,
    paypal: json['paypal'] as String,
    bankAccountNumber: json['bank_account_number'] as String,
    bankAccountName: json['bank_account_name'] as String,
    bankName: json['bank_name'] as String,
    userId: json['user_id'] as String,
  );
}

Map<String, dynamic> _$PaymentMethodResponseToJson(
        PaymentMethodResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'wechat': instance.wechat,
      'cod': instance.cod,
      'paypal': instance.paypal,
      'bank_account_number': instance.bankAccountNumber,
      'bank_account_name': instance.bankAccountName,
      'bank_name': instance.bankName,
      'user_id': instance.userId,
    };
