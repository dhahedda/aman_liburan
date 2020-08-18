import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class NotificationRepository {
  Future<GlobalResponse> getNotifications() async {
    try {
      String pathUrl = '/get_notifications';
      final http.Response response =
          await ApiClient().httpGetHelper(pathUrl, 'getNotifications');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      String errorMessage =
          "Exception occured: ${error.toString()} stackTrace: ${stacktrace.toString()}";
      print(errorMessage);
      return GlobalResponse.withError(errorMessage);
    }
  }

  Future<GlobalResponse> confirmAppointment({@required ConfirmAppointmentParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/confirm_appointment', params.toJson(), 'Confirm Appointment');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  Future<GlobalResponse> sendTrustCoin({@required SendTrustCoinParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/insert_trust_coin', params.toJson(), 'Send Trust Coin');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

}
