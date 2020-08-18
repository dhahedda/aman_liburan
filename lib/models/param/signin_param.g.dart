// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninParam _$SigninParamFromJson(Map<String, dynamic> json) {
  return SigninParam(
    email: json['email'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$SigninParamToJson(SigninParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
