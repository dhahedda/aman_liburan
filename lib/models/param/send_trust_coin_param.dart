// To parse this JSON data, do
//
//     final sendTrustCoinParam = sendTrustCoinParamFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

SendTrustCoinParam sendTrustCoinParamFromJson(String str) => SendTrustCoinParam.fromJson(json.decode(str));

String sendTrustCoinParamToJson(SendTrustCoinParam data) => json.encode(data.toJson());

class SendTrustCoinParam {
    SendTrustCoinParam({
        @required this.type,
        @required this.receiverId,
        @required this.appointmentId,
    });

    String type;
    String receiverId;
    String appointmentId;

    factory SendTrustCoinParam.fromJson(Map<String, dynamic> json) => SendTrustCoinParam(
        type: json["type"] == null ? null : json["type"],
        receiverId: json["receiver_id"] == null ? null : json["receiver_id"],
        appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "receiver_id": receiverId == null ? null : receiverId,
        "appointment_id": appointmentId == null ? null : appointmentId,
    };
}
