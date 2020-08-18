import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/api_client.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {

  Future<GlobalResponse> submitCreditCardPayment({@required PaymentCreditCardParam params}) async {
    try {
      final http.Response response = await ApiClient().httpPostHelper('/credit_card_payment', params.toJson(), 'Submit CreditCard Payment');
      final json = jsonDecode(response.body);
      return GlobalResponse.fromJson(json);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return GlobalResponse.withError("$error");
    }
  }

}
