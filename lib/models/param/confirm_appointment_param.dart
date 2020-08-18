// To parse this JSON data, do
//
//     final confirmAppointmentParam = confirmAppointmentParamFromJson(jsonString);

import 'dart:convert';

ConfirmAppointmentParam confirmAppointmentParamFromJson(String str) => ConfirmAppointmentParam.fromJson(json.decode(str));

String confirmAppointmentParamToJson(ConfirmAppointmentParam data) => json.encode(data.toJson());

class ConfirmAppointmentParam {
    ConfirmAppointmentParam({
        this.id,
        this.status,
    });

    String id;
    String status;

    factory ConfirmAppointmentParam.fromJson(Map<String, dynamic> json) => ConfirmAppointmentParam(
        id: json["_id"] == null ? null : json["_id"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "status": status == null ? null : status,
    };
}
