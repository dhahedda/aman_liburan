part of 'appointment_seller_bloc.dart';

abstract class AppointmentSellerEvent extends Equatable {
  const AppointmentSellerEvent();
}

class GetSellerAppointmentEvent extends AppointmentSellerEvent{

  @override
  List<Object> get props => [];
}

class AcceptNotificationEvent extends AppointmentSellerEvent {
  final String appointmentId;

  AcceptNotificationEvent({@required this.appointmentId});

  @override
  List<Object> get props => [];
}

class FinishAppointmentEvent extends AppointmentSellerEvent {
  final FinishAppointmentParam finishAppointmentParam;

  FinishAppointmentEvent({this.finishAppointmentParam});

  @override
  List<Object> get props => [finishAppointmentParam];
}

class RejectNotificationEvent extends AppointmentSellerEvent {
  final String appointmentId;

  RejectNotificationEvent({@required this.appointmentId});

  @override
  List<Object> get props => [];
}

class RescheduleAppointmentEvent extends AppointmentSellerEvent {
  final RescheduleAppointmentParam rescheduleAppointmentParam;

  RescheduleAppointmentEvent({this.rescheduleAppointmentParam});

  @override
  List<Object> get props => [rescheduleAppointmentParam];
}

class GenerateChatRoomEvent extends AppointmentSellerEvent{
  final String receiverid;

  GenerateChatRoomEvent({this.receiverid});

  @override
  List<Object> get props => [receiverid];
}