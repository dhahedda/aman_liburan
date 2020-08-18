import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class ProductListRepository{
  Future<GlobalResponse> postEditPricing({@required EditPricingParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/edit_pricing', params.toJson(), 'postEditPricing');
      final json = jsonDecode(response.body);
      final GlobalResponse globalResponse = GlobalResponse.fromJson(json);
      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
  
  Future<GlobalResponse> postMarkAsSold({@required MarkAsSoldParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/mark_as_sold', params.toJson(), 'postMarkAsSold');
      final utf8Body = utf8.decode(response.body.runes.toList());
      final json = jsonDecode(utf8Body);
      final GlobalResponse globalResponse = GlobalResponse.fromJson(json);
      return globalResponse;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return GlobalResponse.withError('$error');
    }
  }
}