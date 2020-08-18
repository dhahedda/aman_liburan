// To parse this JSON data, do
//
//     final createAppointmentParam = createAppointmentParamFromJson(jsonString);

import 'dart:convert';

CreateAppointmentParam createAppointmentParamFromJson(String str) => CreateAppointmentParam.fromJson(json.decode(str));

String createAppointmentParamToJson(CreateAppointmentParam data) => json.encode(data.toJson());

class CreateAppointmentParam {
    String status;
    bool isDelivery;
    int meetingTime;
    double meetingLat;
    double meetingLng;
    String productId;
    String sellerId;

    CreateAppointmentParam({
        this.status,
        this.isDelivery,
        this.meetingTime,
        this.meetingLat,
        this.meetingLng,
        this.productId,
        this.sellerId,
    });

    factory CreateAppointmentParam.fromJson(Map<String, dynamic> json) => CreateAppointmentParam(
        status: json["status"] == null ? null : json["status"],
        isDelivery: json["is_delivery"] == null ? null : json["is_delivery"],
        meetingTime: json["meeting_time"] == null ? null : json["meeting_time"],
        meetingLat: json["meeting_lat"] == null ? null : json["meeting_lat"].toDouble(),
        meetingLng: json["meeting_lng"] == null ? null : json["meeting_lng"].toDouble(),
        productId: json["product_id"] == null ? null : json["product_id"],
        sellerId: json["seller_id"] == null ? null : json["seller_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "is_delivery": isDelivery == null ? null : isDelivery,
        "meeting_time": meetingTime == null ? null : meetingTime,
        "meeting_lat": meetingLat == null ? null : meetingLat,
        "meeting_lng": meetingLng == null ? null : meetingLng,
        "product_id": productId == null ? null : productId,
        "seller_id": sellerId == null ? null : sellerId,
    };
}
