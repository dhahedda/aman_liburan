import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class DetailProductRepository{
  Future<GlobalResponse> getDetailProduct({@required DetailProductParam params}) async {
    try {
      String pathUrl = '/products/'+params.id;
      final http.Response response = await ApiClient().httpGetHelper(pathUrl, 'getDetailProduct');
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