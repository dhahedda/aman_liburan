import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/appointment_repository.dart';

part 'create_appointment_event.dart';
part 'create_appointment_state.dart';

class CreateAppointmentBloc
    extends Bloc<CreateAppointmentEvent, CreateAppointmentState> {
  @override
  CreateAppointmentState get initialState => CreateAppointmentInitial();

  @override
  Stream<CreateAppointmentState> mapEventToState(
      CreateAppointmentEvent event) async* {
    if (event is InitialCreateappointmentEvent) {
      DateTime selectedDateTime = event.selectedDateTime;
      GlobalResponse response = event.response;

      Position lastPosition = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      if (lastPosition == null) {
        lastPosition = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
      double startLatitude = lastPosition.latitude;
      double startLongitude = lastPosition.longitude;
      double endLatitude = response.data.item.location.latitude;
      double endLongitude = response.data.item.location.longitude;

      double distanceInMeters = await Geolocator().distanceBetween(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      );

      double distanceInKm = (distanceInMeters / 1000);
      String distanceRadius = "${num.parse(distanceInKm.toStringAsExponential(1)).toString()} Km";

      yield CreateAppointmentResponse(
        selectedDateTime: selectedDateTime,
        response: response,
        distanceRadius: distanceRadius
      );
    }

    if (event is DateChangeEvent) {
      final currentState = state;
      DateTime selectedDateTime = event.selectedDateTime;

      if (currentState is CreateAppointmentResponse) {
        yield currentState.copyWith(time: selectedDateTime);
      }
    }

    if (event is SubmitAppointmentEvent) {
      CreateAppointmentParam param = event.createAppointmentParam;

      GlobalResponse response =
          await AppointmentRepository().createAppointment(params: param);
      yield SubmitAppointmentResponse(response: response);
    }
  }
}
