import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class AddProductRepository {
  Future<GlobalResponse> getCategories() async {
    try {
      String path = '/get_categories';
      final http.Response response = await ApiClient().httpGetHelper(path, 'getCategories');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postAddProduct({@required AddProductParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/add_product', params.toJson(), 'postAddProduct');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }

  Future<GlobalResponse> postEditProduct({@required EditProductParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/edit_product', params.toJson(), 'postEditProduct');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
}
