part of 'appointment_buyer_bloc.dart';

abstract class AppointmentBuyerState extends Equatable {
  const AppointmentBuyerState();
}

class AppointmentBuyerInitial extends AppointmentBuyerState {
  @override
  List<Object> get props => [];
}


class AppointmentBuyerResponse extends AppointmentBuyerState {
  final GlobalResponse response;

  AppointmentBuyerResponse({this.response});

  @override
  List<Object> get props => [response];
}

class AppointmentBuyerError extends AppointmentBuyerState {
  final String message;

  AppointmentBuyerError({@required this.message});

  @override
  List<Object> get props => [message];
}

class InitiateChatResponse extends AppointmentBuyerState {
  final GlobalResponse response;
  final String receiverid;

  InitiateChatResponse({@required this.response, @required this.receiverid});

  @override
  List<Object> get props => [response, receiverid];
}