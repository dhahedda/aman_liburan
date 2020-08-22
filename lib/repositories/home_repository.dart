import 'dart:async';
import 'dart:convert';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  Future<dynamic> getPlace({@required EmptyParam params}) async {
    try {
      final http.Response response = await ApiClient().httpGetHelper('/place', 'getPlace');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return json;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

  Future<GlobalResponse> getProductCategory({@required String categoryName}) async{
    try {
      String url = "/search?category="+categoryName;
      final http.Response response = await ApiClient().httpGetHelper(url, 'getProductCategory');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

}
