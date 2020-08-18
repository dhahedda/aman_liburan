part of 'appointment_seller_bloc.dart';

abstract class AppointmentSellerState extends Equatable {
  const AppointmentSellerState();
}

class AppointmentSellerInitial extends AppointmentSellerState {
  @override
  List<Object> get props => [];
}

class AppointmentSellerResponse extends AppointmentSellerState {
  final GlobalResponse response;

  AppointmentSellerResponse({this.response});

  @override
  List<Object> get props => [response];
}

class AppointmentConfirmationResponse extends AppointmentSellerState {
  final GlobalResponse response;

  AppointmentConfirmationResponse({this.response});

  @override
  List<Object> get props => [response];
}

class AppointmentFinished extends AppointmentSellerState {
  final GlobalResponse response;

  AppointmentFinished({this.response});

  @override
  List<Object> get props => [response];
}

class AppointmentRescheduled extends AppointmentSellerState {
  final GlobalResponse response;

  AppointmentRescheduled({this.response});

  @override
  List<Object> get props => [response];
}


class AppointmentSellerError extends AppointmentSellerState {
  final String message;

  AppointmentSellerError({@required this.message});

  @override
  List<Object> get props => [message];
}

class InitiateChatResponse extends AppointmentSellerState {
  final GlobalResponse response;
  final String receiverid;

  InitiateChatResponse({@required this.response, @required this.receiverid});

  @override
  List<Object> get props => [response, receiverid];
}