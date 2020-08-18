// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_konbini_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentKonbiniParam _$PaymentKonbiniParamFromJson(Map<String, dynamic> json) {
  return PaymentKonbiniParam(
    amount: json['amount'] as int,
    currency: json['currency'] as String,
    sourceId: json['source_id'] as String,
  );
}

Map<String, dynamic> _$PaymentKonbiniParamToJson(
        PaymentKonbiniParam instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'source_id': instance.sourceId,
    };
