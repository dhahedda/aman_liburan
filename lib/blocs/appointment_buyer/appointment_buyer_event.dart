part of 'appointment_buyer_bloc.dart';

abstract class AppointmentBuyerEvent extends Equatable {
  const AppointmentBuyerEvent();
}

class GetBuyerAppointmentEvent extends AppointmentBuyerEvent {
  @override
  List<Object> get props => [];
}

class GenerateChatRoomEvent extends AppointmentBuyerEvent{
  final String receiverid;

  GenerateChatRoomEvent({this.receiverid});

  @override
  List<Object> get props => [receiverid];
}