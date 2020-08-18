part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  final GlobalResponse response;
  final List<Placemark> placemarks;
  final bool acceptCashOnDelivery;

  const AccountState({ this.response, this.placemarks, this.acceptCashOnDelivery });

  @override
  List<Object> get props => [response, placemarks, acceptCashOnDelivery];
}

class AccountInit extends AccountState {}

class AccountLoading extends AccountState {}

class AccountResponse extends AccountState {
  final GlobalResponse response;
  final List<Placemark> placemarks;
  final bool acceptCashOnDelivery;

  const AccountResponse({ @required this.response, @required this.placemarks, this.acceptCashOnDelivery }) : super(response:response, placemarks: placemarks, acceptCashOnDelivery:acceptCashOnDelivery);

  AccountResponse copyWith({GlobalResponse response, List<Placemark> placemarks, bool acceptCashOnDelivery}){
    return AccountResponse(
      response: response ?? this.response,
      placemarks: placemarks ?? this.placemarks,
      acceptCashOnDelivery: acceptCashOnDelivery ?? this.acceptCashOnDelivery,
    );
  }

  @override
  List<Object> get props => [response, placemarks, acceptCashOnDelivery];
}

class AccountSignOutResponse extends AccountState {
  final GlobalResponse response;

  const AccountSignOutResponse({ @required this.response}) : super(response:response);

  @override
  List<Object> get props => [response];
}

class UpdateProfileResponse extends AccountState {
  final GlobalResponse response;

  const UpdateProfileResponse({ @required this.response}) : super(response:response);

  @override
  List<Object> get props => [response];
}

class UpdatePaymentResponse extends AccountState {
  final GlobalResponse response;

  const UpdatePaymentResponse({ @required this.response}) : super(response:response);

  @override
  List<Object> get props => [response];
}

class AccountError extends AccountState {
  final String message;

  AccountError({@required this.message});

  @override
  List<Object> get props => [message];
}
