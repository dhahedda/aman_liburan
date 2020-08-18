import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/global_response.dart';

import 'api_provider.dart';

class ApiRepository {
  final apiProvider = ApiProvider();

  Future<GlobalResponse> doLogin({@required SigninParam loginParam}) => apiProvider.doLogin(loginParam);
  Future<GlobalResponse> getDashboard() => apiProvider.getDashboard();
  Future<GlobalResponse> getSearch({@required String query}) => apiProvider.getSearch(query: query);
  Future<GlobalResponse> getProductCategory({@required String categoryId}) => apiProvider.getProductCategory(categoryId);
}
