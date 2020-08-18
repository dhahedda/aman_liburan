part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentEvent extends Equatable {
  const CreateAppointmentEvent();

  @override
  List<Object> get props => [];
}

class InitialCreateappointmentEvent extends CreateAppointmentEvent {
  final DateTime selectedDateTime;
  final GlobalResponse response;

  InitialCreateappointmentEvent(
      {@required this.selectedDateTime, @required this.response});

  @override
  List<Object> get props => [selectedDateTime, response];
}

class SubmitAppointmentEvent extends CreateAppointmentEvent {
  final CreateAppointmentParam createAppointmentParam;

  SubmitAppointmentEvent({@required this.createAppointmentParam});

  @override
  List<Object> get props => [createAppointmentParam];
}

class DateChangeEvent extends CreateAppointmentEvent {
  final DateTime selectedDateTime;

  DateChangeEvent({this.selectedDateTime});

  @override
  List<Object> get props => [selectedDateTime];
}
