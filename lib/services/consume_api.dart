import 'package:aman_liburan/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ConsumeApi {
  var _baseUrl = 'http://aman-liburan.herokuapp.com';
  tes() async {
    var token = await UserServices().jwt();
    var result = await http.get('$_baseUrl/getprofile',
        headers: {HttpHeaders.authorizationHeader: "${token}"});
    print(result.body);
  }
}
