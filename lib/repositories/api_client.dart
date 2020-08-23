import 'dart:convert';
import 'dart:async';

import 'package:aman_liburan/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:aman_liburan/components/data_session.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/signin_repository.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._privateConstructor();
  ApiClient._privateConstructor();
  factory ApiClient() => _instance;

  // static String baseUrl = 'https://go.2gaijin.com';
  static String baseUrl = 'http://aman-liburan.herokuapp.com';

  Future<http.Response> httpGetHelper(String path, String methodName) async {
    final authToken = await DataSession().getAuthToken();
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-type': 'application/json',
      'Authorization': authToken,
    };
    final response = await http.get(baseUrl + path, headers: headers).timeout(Duration(seconds: 60));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      if (response.body == 'token tidak valid') {
        print('Auth token expired. Invoiking refresh token.');
        final email = await DataSession().getEmail();
        final password = await DataSession().getPassword();
        await UserServices().signIn(email, password);
        return httpGetHelper(path, methodName);
      }
      print('Response ==>');
      print(response.body);
      print(' <== End HTTP GET $path');
      return response;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid token');
    } else if (response.statusCode == 500) {
      try {
        SigninParam signinParam = SigninParam(
          email: await DataSession().getEmail(),
          password: await DataSession().getPassword(),
        );
        await ApiClient().httpPostHelper('/sign_in', signinParam.toJson(), 'postSignin');
        return httpGetHelper(path, methodName);
      } catch (error) {
        throw Exception('Request failed: $methodName');
      }
    } else {
      throw Exception('Request failed: $methodName');
    }
  }

  Future<http.Response> httpPostHelper(String path, Map<String, dynamic> bodyToJson, String methodName) async {
    final authToken = await DataSession().getAuthToken();
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-type': 'application/json',
      'Authorization': authToken,
    };
    final response = await http.post('$baseUrl$path', headers: headers, body: jsonEncode(bodyToJson)).timeout(Duration(seconds: 120));
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final json = jsonDecode(response.body);
      final GlobalResponse globalResponse = GlobalResponse.fromJson(json);
      if (globalResponse.message == 'Token Expired' || globalResponse.message == 'Unauthorized') {
        print('Auth token expired. Invoiking refresh token...');
        GlobalResponse tokenResponse = await SigninRepository().postRefreshToken();
        print(tokenResponse);
        return httpPostHelper(path, bodyToJson, methodName);
      }
      print('Response ==>');
      print(response.body);
      print(' <== End HTTP POST $path');
      return response;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid token');
    } else if (response.statusCode == 500) {
      try {
        SigninParam signinParam = SigninParam(
          email: await DataSession().getEmail(),
          password: await DataSession().getPassword(),
        );
        await ApiClient().httpPostHelper('/sign_in', signinParam.toJson(), 'postSignin');
        return httpPostHelper(path, bodyToJson, methodName);
      } catch (error) {
        throw Exception('Request failed: $methodName');
      }
    } else {
      throw Exception('Request failed: $methodName');
    }
  }

  Future<http.Response> httpPostRefreshToken() async {
    final refreshToken = await DataSession().getRefreshToken();
    Map<String, String> headers = {
      'Accept': '*/*',
      'Content-type': 'application/json',
      'Authorization': refreshToken,
    };
    http.Response response = await http.post('$baseUrl/refresh_token', headers: headers);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print('Response ==>');
      print(response.body);
      print(' <== End HTTP POST /refresh_token');
      return response;
    } else if (response.statusCode == 401) {
      throw Exception('Invalid token');
    } else if (response.statusCode == 500) {
      try {
        SigninParam signinParam = SigninParam(
          email: await DataSession().getEmail(),
          password: await DataSession().getPassword(),
        );
        http.Response signinResponse = await ApiClient().httpPostHelper('/sign_in', signinParam.toJson(), 'postSignin');
        print(signinResponse);
        final json = jsonDecode(signinResponse.body);
        final GlobalResponse globalResponse = GlobalResponse.fromJson(json);
        DataSession().setRefreshToken(globalResponse.data.user.refreshToken);
        DataSession().setAuthToken(globalResponse.data.user.authenticationToken);
        return signinResponse;
      } catch (error) {
        throw Exception('Request failed: refreshToken');
      }
    } else {
      throw Exception('Request failed: refreshToken');
    }
  }
}
