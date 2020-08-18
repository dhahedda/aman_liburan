import 'package:json_annotation/json_annotation.dart';

part 'signin_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SigninParam {
  String email;
  String password;

  SigninParam({this.email, this.password});

  factory SigninParam.fromJson(Map<String, dynamic> json) => _$SigninParamFromJson(json);

  Map<String, dynamic> toJson() => _$SigninParamToJson(this);
}
