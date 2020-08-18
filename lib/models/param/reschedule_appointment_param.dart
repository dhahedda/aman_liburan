// To parse this JSON data, do
//
//     final rescheduleAppointmentParam = rescheduleAppointmentParamFromJson(jsonString);

import 'dart:convert';

RescheduleAppointmentParam rescheduleAppointmentParamFromJson(String str) => RescheduleAppointmentParam.fromJson(json.decode(str));

String rescheduleAppointmentParamToJson(RescheduleAppointmentParam data) => json.encode(data.toJson());

class RescheduleAppointmentParam {
    RescheduleAppointmentParam({
        this.id,
        this.meetingTime,
    });

    String id;
    int meetingTime;

    factory RescheduleAppointmentParam.fromJson(Map<String, dynamic> json) => RescheduleAppointmentParam(
        id: json["_id"] == null ? null : json["_id"],
        meetingTime: json["meeting_time"] == null ? null : json["meeting_time"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "meeting_time": meetingTime == null ? null : meetingTime,
    };
}
