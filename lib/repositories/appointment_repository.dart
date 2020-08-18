import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class AppointmentRepository {
  Future<GlobalResponse> createAppointment({@required CreateAppointmentParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/insert_appointment', params.toJson(), 'Insert Appointment');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  Future<GlobalResponse> finishAppointment({@required FinishAppointmentParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/finish_appointment', params.toJson(), 'Finish Appointment');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  Future<GlobalResponse> rescheduleAppointment({@required RescheduleAppointmentParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/reschedule_appointment', params.toJson(), 'Reschedule Appointment');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }
 
  Future<GlobalResponse> getSellerAppointment() async {
    try {
      String pathUrl = '/get_seller_appointments';
      final http.Response response = await ApiClient().httpGetHelper(pathUrl, 'getSellerAppointments');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      String errorMessage = "Exception occured: ${error.toString()} stackTrace: ${stacktrace.toString()}";
      print(errorMessage);
      return GlobalResponse.withError(errorMessage);
    }
  }

  Future<GlobalResponse> getBuyerAppointment() async {
    try {
      String pathUrl = '/get_buyer_appointments';
      final http.Response response = await ApiClient().httpGetHelper(pathUrl, 'getBuyerAppointments');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      String errorMessage = "Exception occured: ${error.toString()} stackTrace: ${stacktrace.toString()}";
      print(errorMessage);
      return GlobalResponse.withError(errorMessage);
    }
  }
}
