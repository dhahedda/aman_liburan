import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';

class ProfileRepository{
  Future<dynamic> getProfile({@required EmptyParam params}) async {
    try {
      final response = await ApiClient().httpPostHelper('/profile', params.toJson(), 'API Profile');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return json;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  // Future<GlobalResponse> getSellerProfileProfile({@required ProfileSellerParam params}) async {
  //   try {
  //     String pathUrl = '/profile_visitor?user_id='+params.userId;
  //     final http.Response response =
  //         await ApiClient().httpGetHelper(pathUrl, 'getProfileVisitor');
  //     final utf8Body = utf8.decode(response.body.runes.toList());
  //     final json = jsonDecode(utf8Body);
  //     return GlobalResponse.fromJson(json);
  //   } catch (error, stacktrace) {
  //     String errorMessage =
  //         "Exception occured: ${error.toString()} stackTrace: ${stacktrace.toString()}";
  //     print(errorMessage);
  //     return GlobalResponse.withError(errorMessage);
  //   }
  // }

  // Future<GlobalResponse> getProfileInfo() async {
  //   try {
  //     final http.Response response = await ApiClient().httpPostHelper('/get_profile_info', null, 'getProfileInfo');
  //     final utf8Body = utf8.decode(response.body.runes.toList());
  //     final json = jsonDecode(utf8Body);
  //     return GlobalResponse.fromJson(json);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return GlobalResponse.withError("$error");
  //   }
  // }

  // Future<GlobalResponse> updateProfile({@required UpdateProfileParam params}) async {
  //   try {
  //     final http.Response response = await ApiClient().httpPostHelper('/update_profile', params.toJson(), 'updateProfile');
  //     final utf8Body = utf8.decode(response.body.runes.toList());
  //     final json = jsonDecode(utf8Body);
  //     return GlobalResponse.fromJson(json);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return GlobalResponse.withError("$error");
  //   }
  // }

  // Future<GlobalResponse> updatePayment({@required UpdatePaymentParam params}) async {
  //   try {
  //     final http.Response response = await ApiClient().httpPostHelper('/update_payment_method', params.toJson(), 'updatePaymentMethod');
  //     final utf8Body = utf8.decode(response.body.runes.toList());
  //     final json = jsonDecode(utf8Body);
  //     return GlobalResponse.fromJson(json);
  //   } catch (error, stacktrace) {
  //     print("Exception occured: $error stackTrace: $stacktrace");
  //     return GlobalResponse.withError("$error");
  //   }
  // }

}