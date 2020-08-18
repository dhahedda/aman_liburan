part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetAccountEvent extends AccountEvent {}

class GetSellerAccountEvent extends AccountEvent {
  final String userId;

  GetSellerAccountEvent({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateProfileEvent extends AccountEvent {
  final UpdateProfileParam updateProfileParam;

  UpdateProfileEvent({@required this.updateProfileParam});

  @override
  List<Object> get props => [updateProfileParam];
}

class UpdatePaymentEvent extends AccountEvent {
  final UpdatePaymentParam updatePaymentParam;

  UpdatePaymentEvent({@required this.updatePaymentParam});

  @override
  List<Object> get props => [updatePaymentParam];
}

class CheckBoxAccountEvent extends AccountEvent {
  final bool acceptCashOnDelivery;

  CheckBoxAccountEvent({@required this.acceptCashOnDelivery});

  @override
  List<Object> get props => [acceptCashOnDelivery];
}

class SignOutEvent extends AccountEvent {}
