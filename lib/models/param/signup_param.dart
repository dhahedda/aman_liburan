import 'package:json_annotation/json_annotation.dart';

part 'signup_param.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SignupParam {
  String email;
  String password;
  String passwordConfirmation;

  SignupParam(this.email, this.password, this.passwordConfirmation);

  factory SignupParam.fromJson(Map<String, dynamic> json) => _$SignupParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignupParamToJson(this);
}
