import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/models/response/global_response.dart';
import 'package:aman_liburan/repositories/payment_repository.dart';

part 'payment_method_event.dart';
part 'payment_method_state.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  @override
  PaymentMethodState get initialState => PaymentMethodInitial();

  @override
  Stream<PaymentMethodState> mapEventToState(PaymentMethodEvent event) async* {
    if(event is PaymentMethodInitialEvent){
      yield PaymentMethodResponseState();
    }

    if (event is PaymentCreditCardEvent) {
      try {
        PaymentCreditCardParam paymentCreditCardParam = event.paymentCreditCardParam;
        final GlobalResponse response = await PaymentRepository().submitCreditCardPayment(params: paymentCreditCardParam);
        yield PaymentMethodResponseState(response: response);
      } catch (e) {
        yield PaymentMethodError(message: "Some Error => ${e.toString()}");
      }
    }
  }
}
