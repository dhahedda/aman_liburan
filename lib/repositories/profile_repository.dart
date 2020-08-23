import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';

class ProfileRepository {
  Future<dynamic> getProfile({@required EmptyParam params}) async {
    try {
      String pathUrl = '/profile';
      final response = await ApiClient().httpGetHelper(pathUrl, 'getProfile');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      return json;
    } catch (error, stacktrace) {
      String errorMessage = "Exception occured: ${error.toString()} stackTrace: ${stacktrace.toString()}";
      print(errorMessage);
      return GlobalResponse.withError(errorMessage);
    }
  }
}
