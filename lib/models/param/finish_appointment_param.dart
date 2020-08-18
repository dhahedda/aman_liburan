// To parse this JSON data, do
//
//     final finishAppointmentParam = finishAppointmentParamFromJson(jsonString);

import 'dart:convert';

FinishAppointmentParam finishAppointmentParamFromJson(String str) => FinishAppointmentParam.fromJson(json.decode(str));

String finishAppointmentParamToJson(FinishAppointmentParam data) => json.encode(data.toJson());

class FinishAppointmentParam {
    FinishAppointmentParam({
        this.id,
    });

    String id;

    factory FinishAppointmentParam.fromJson(Map<String, dynamic> json) => FinishAppointmentParam(
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
    };
}
