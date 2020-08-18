part of 'create_appointment_bloc.dart';

abstract class CreateAppointmentState extends Equatable {
  const CreateAppointmentState();

  @override
  List<Object> get props => [];
}

class CreateAppointmentInitial extends CreateAppointmentState {}

class CreateAppointmentResponse extends CreateAppointmentState {
  final DateTime selectedDateTime;
  final GlobalResponse response;
  final String distanceRadius;

  CreateAppointmentResponse({@required this.selectedDateTime, @required this.response, this.distanceRadius});

  CreateAppointmentResponse copyWith({GlobalResponse resp, DateTime time, String distanceRadius}){
    return CreateAppointmentResponse(
      response: resp ?? this.response,
      selectedDateTime: time ?? this.selectedDateTime,
      distanceRadius: distanceRadius ?? this.distanceRadius,
    );
  }

  @override
  List<Object> get props => [selectedDateTime, response, distanceRadius];
}

class SubmitAppointmentResponse extends CreateAppointmentState {
  final GlobalResponse response;

  SubmitAppointmentResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class CreateAppointmentError extends CreateAppointmentState {
  final String message;

  CreateAppointmentError(this.message);

  @override
  List<Object> get props => [message];
}