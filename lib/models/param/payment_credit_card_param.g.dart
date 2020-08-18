// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_credit_card_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentCreditCardParam _$PaymentCreditCardParamFromJson(
    Map<String, dynamic> json) {
  return PaymentCreditCardParam(
    amount: json['amount'] as int,
    currency: json['currency'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$PaymentCreditCardParamToJson(
        PaymentCreditCardParam instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'token': instance.token,
    };
