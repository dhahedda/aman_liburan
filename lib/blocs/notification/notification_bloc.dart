import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/models/response/global_response.dart';
import 'package:aman_liburan/repositories/notification_repository.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is GetNotificationEvent) {
      try {
        final GlobalResponse response =
            await NotificationRepository().getNotifications();
        yield NotificationResponseState(response: response);
      } catch (e) {
        yield NotificationError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is AcceptNotificationEvent) {
      try {
        ConfirmAppointmentParam params = ConfirmAppointmentParam(
            id: event.appointmentId, status: "accepted");
        final GlobalResponse response =
            await NotificationRepository().confirmAppointment(params: params);
        yield NotificationConfirmationResponse(response: response);
      } catch (e) {
        yield NotificationError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is RejectNotificationEvent) {
      try {
        ConfirmAppointmentParam params = ConfirmAppointmentParam(
            id: event.appointmentId, status: "rejected");
        final GlobalResponse response =
            await NotificationRepository().confirmAppointment(params: params);
        yield NotificationConfirmationResponse(response: response);
      } catch (e) {
        yield NotificationError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is SendTrustCoinEvent) {
      try {
        SendTrustCoinParam params = event.param;
        final GlobalResponse response = await NotificationRepository().sendTrustCoin(params: params);
        yield NotificationConfirmationResponse(response: response);
      } catch (e) {
        yield NotificationError(message: "Some Error => ${e.toString()}");
      }
    }

  }
}
