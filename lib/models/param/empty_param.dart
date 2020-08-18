// To parse this JSON data, do
//
//     final EmptyParam = emptyParamFromJson(jsonString);

import 'dart:convert';

EmptyParam emptyParamFromJson(String str) => EmptyParam.fromJson(json.decode(str));

String emptyParamToJson(EmptyParam data) => json.encode(data.toJson());

class EmptyParam {
    EmptyParam();

    factory EmptyParam.fromJson(Map<String, String> json) => EmptyParam();

    Map<String, String> toJson() => {};
}
