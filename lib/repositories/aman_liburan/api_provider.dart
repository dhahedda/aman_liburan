import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/global_response.dart';

class ApiProvider{
  static String baseUrl   = "http://35.243.97.141";
  // static String baseUrl   = "https://rails-api.2gaijin.com";
  // static String baseUrl   = "https://go.2gaijin.com";

  var customHeaders = {
    'content-type': 'application/json',
  };

  final Dio _dio = Dio(
      new BaseOptions(
        baseUrl       : baseUrl,
        contentType   : Headers.jsonContentType,
        responseType  : ResponseType.json,
      ),
  );

  var loginUrlSample      = '/login';
  var loginUrl            = '/sign_in';
  var registerUrl         = '/auth';
  var dashboardUrl        = '/';
  var searchProductUrl    = '/search';
  var detailProductUrl    = '/products';

  // Login
  Future<GlobalResponse> doLogin(SigninParam loginParam) async {
    var params = {
      'email'     : loginParam.email,
      'password'  : loginParam.password,
      'fcm_token' : loginParam.password
    };

    try {
      // _dio.interceptors.add(LoggingInterceptor());
      var response = await _dio.post(loginUrl, data: params);
      return GlobalResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  // Register
  Future<GlobalResponse> doRegister(SignupParam registerParam) async {
    var params = {
      'email'                 : registerParam.email,
      'password'              : registerParam.password,
      'password_confirmation' : registerParam.passwordConfirmation
    };

    try {
      var response = await _dio.post(registerUrl, options: Options(contentType:Headers.formUrlEncodedContentType), data: params);
      return GlobalResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  // Get Dashboard
  Future<GlobalResponse> getDashboard() async {
    try {
      // _dio.interceptors.add(LoggingInterceptor());
      var response = await _dio.get(dashboardUrl);
      return GlobalResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  //Get Product Category
  Future<GlobalResponse> getSearch({@required String query}) async {
     var params = {
      'q'  : query,
    };

    try {
      // _dio.interceptors.add(LoggingInterceptor());
      var response = await _dio.get(searchProductUrl, queryParameters: params);
      return GlobalResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  //Get Product Category
  Future<GlobalResponse> getProductCategory(categoryId) async {
     var params = {
      'categoryname'  : categoryId,
      'sortby'        : 1
    };

    try {
      // _dio.interceptors.add(LoggingInterceptor());
      var response = await _dio.get(searchProductUrl, queryParameters: params);
      return GlobalResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

}