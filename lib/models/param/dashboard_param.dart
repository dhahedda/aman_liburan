// To parse this JSON data, do
//
//     final dashboardParam = dashboardParamFromJson(jsonString);

import 'dart:convert';

DashboardParam dashboardParamFromJson(String str) => DashboardParam.fromJson(json.decode(str));

String dashboardParamToJson(DashboardParam data) => json.encode(data.toJson());

class DashboardParam {
    DashboardParam();

    factory DashboardParam.fromJson(Map<String, String> json) => DashboardParam();

    Map<String, String> toJson() => {};
}
