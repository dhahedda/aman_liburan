// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupParam _$SignupParamFromJson(Map<String, dynamic> json) {
  return SignupParam(
    json['email'] as String,
    json['password'] as String,
    json['password_confirmation'] as String,
  );
}

Map<String, dynamic> _$SignupParamToJson(SignupParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };
