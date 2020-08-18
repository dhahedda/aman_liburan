import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/appointment_repository.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';
import 'package:aman_liburan/repositories/notification_repository.dart';

part 'appointment_seller_event.dart';
part 'appointment_seller_state.dart';

class AppointmentSellerBloc
    extends Bloc<AppointmentSellerEvent, AppointmentSellerState> {
  @override
  AppointmentSellerState get initialState => AppointmentSellerInitial();

  @override
  Stream<AppointmentSellerState> mapEventToState(
      AppointmentSellerEvent event) async* {
    if (event is GetSellerAppointmentEvent) {
      try {
        final GlobalResponse response = await AppointmentRepository().getSellerAppointment();
        yield AppointmentSellerResponse(response: response);
      } catch (e) {
        yield AppointmentSellerError(message: e.toString());
      }
    }

    if (event is AcceptNotificationEvent) {
      try {
        ConfirmAppointmentParam params = ConfirmAppointmentParam(
            id: event.appointmentId, status: "accepted");
        final GlobalResponse response =
            await NotificationRepository().confirmAppointment(params: params);
        yield AppointmentConfirmationResponse(response: response);
      } catch (e) {
        yield AppointmentSellerError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is RejectNotificationEvent) {
      try {
        ConfirmAppointmentParam params = ConfirmAppointmentParam(
            id: event.appointmentId, status: "rejected");
        final GlobalResponse response =
            await NotificationRepository().confirmAppointment(params: params);
        yield AppointmentConfirmationResponse(response: response);
      } catch (e) {
        yield AppointmentSellerError(message: "Some Error => ${e.toString()}");
      }
    }
    
    if (event is FinishAppointmentEvent) {
      try {
        FinishAppointmentParam params = event.finishAppointmentParam;
        final GlobalResponse response =
            await AppointmentRepository().finishAppointment(params: params);
        yield AppointmentFinished(response: response);
      } catch (e) {
        yield AppointmentSellerError(message: e.toString());
      }
    }

    if (event is RescheduleAppointmentEvent) {
      try {
        RescheduleAppointmentParam params = event.rescheduleAppointmentParam;
        final GlobalResponse response =
            await AppointmentRepository().rescheduleAppointment(params: params);
        yield AppointmentRescheduled(response: response);
      } catch (e) {
        yield AppointmentSellerError(message: e.toString());
      }
    }

    if (event is GenerateChatRoomEvent) {
      String receiverid = event.receiverid;

      try {
        final GlobalResponse response = await ChatRepository().getInitiateChat(
          receiverId: receiverid,
        );
        yield InitiateChatResponse(
          response: response,
          receiverid: receiverid,
        );
      } catch (e) {
        yield AppointmentSellerError(message: e);
      }
    }

  }
}
