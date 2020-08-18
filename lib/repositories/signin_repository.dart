import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class SigninRepository {
  Future<GlobalResponse> postSignin({@required SigninParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/sign_in', params.toJson(), 'postSignin');
      final json = jsonDecode(response.body);
      final globalResponse = GlobalResponse.fromJson(json);
      DataSession().setRefreshToken(globalResponse.data.user.refreshToken);
      DataSession().setAuthToken(globalResponse.data.user.authenticationToken);
      DataSession().setSubscriptionStatus(globalResponse.data.user.isSubscribed);
      print('Successfully logged in with auth token: ${await DataSession().getAuthToken()}');
      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postSignup({@required SignupParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/sign_up', params.toJson(), 'postSignup');
      final json = jsonDecode(response.body);
      final globalResponse = GlobalResponse.fromJson(json);
      DataSession().setRefreshToken(globalResponse.data.user.refreshToken);
      DataSession().setAuthToken(globalResponse.data.user.authenticationToken);
      print('Successfully logged in with auth token: ${await DataSession().getAuthToken()}');
      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postRefreshToken() async {
    try {
      final http.Response response = await ApiClient().httpPostRefreshToken();
      final json = jsonDecode(response.body);
      final globalResponse = GlobalResponse.fromJson(json);
      DataSession().setAuthToken(globalResponse.data.user.authenticationToken);
      print('Successfully refresh auth token: ${await DataSession().getAuthToken()}');
      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postSignOut({@required EmptyParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/sign_out', params.toJson(), 'postSignin');
      final json = jsonDecode(response.body);
      final globalResponse = GlobalResponse.fromJson(json);
      if (globalResponse.status == "Success") {
        DataSession().removeSession();
        print('Successfully logged out..');
      }

      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
}
