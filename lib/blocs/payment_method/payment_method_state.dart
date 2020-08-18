part of 'payment_method_bloc.dart';

abstract class PaymentMethodState extends Equatable {
  const PaymentMethodState();
}

class PaymentMethodInitial extends PaymentMethodState {
  @override
  List<Object> get props => [];
}

class PaymentLoading extends PaymentMethodState {
  @override
  List<Object> get props => [];
}

class PaymentMethodResponseState extends PaymentMethodState {
  final GlobalResponse response;

  PaymentMethodResponseState({this.response});

  @override
  List<Object> get props => [response];
}

class PaymentMethodError extends PaymentMethodState {
  final String message;

  PaymentMethodError({@required this.message});

  @override
  List<Object> get props => [message];
}
