part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class GetSellerProfileEvent extends ProfileEvent {
  final String userId;

  GetSellerProfileEvent({@required this.userId});

  @override
  List<Object> get props => [userId];
}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParam updateProfileParam;

  UpdateProfileEvent({@required this.updateProfileParam});

  @override
  List<Object> get props => [updateProfileParam];
}

class UpdatePaymentEvent extends ProfileEvent {
  final UpdatePaymentParam updatePaymentParam;

  UpdatePaymentEvent({@required this.updatePaymentParam});

  @override
  List<Object> get props => [updatePaymentParam];
}

class CheckBoxProfileEvent extends ProfileEvent {
  final bool acceptCashOnDelivery;

  CheckBoxProfileEvent({@required this.acceptCashOnDelivery});

  @override
  List<Object> get props => [acceptCashOnDelivery];
}

class SignOutEvent extends ProfileEvent {}
