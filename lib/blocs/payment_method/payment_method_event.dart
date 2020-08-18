part of 'payment_method_bloc.dart';

abstract class PaymentMethodEvent extends Equatable {
  const PaymentMethodEvent();
}

class PaymentMethodInitialEvent extends PaymentMethodEvent {
  PaymentMethodInitialEvent();

  @override
  List<Object> get props => [];
}

class PaymentCreditCardEvent extends PaymentMethodEvent {
  final PaymentCreditCardParam paymentCreditCardParam;

  PaymentCreditCardEvent({this.paymentCreditCardParam});

  @override
  List<Object> get props => [paymentCreditCardParam];
}