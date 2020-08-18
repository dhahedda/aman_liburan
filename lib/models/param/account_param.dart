import 'dart:convert';

AccountParam accountParamFromJson(String str) => AccountParam.fromJson(json.decode(str));

String accountParamToJson(AccountParam data) => json.encode(data.toJson());

class AccountParam {
    AccountParam();

    factory AccountParam.fromJson(Map<String, String> json) => AccountParam();

    Map<String, String> toJson() => {};
}