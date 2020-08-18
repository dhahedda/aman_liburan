import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/appointment_repository.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';

part 'appointment_buyer_event.dart';
part 'appointment_buyer_state.dart';

class AppointmentBuyerBloc
    extends Bloc<AppointmentBuyerEvent, AppointmentBuyerState> {
  @override
  AppointmentBuyerState get initialState => AppointmentBuyerInitial();

  @override
  Stream<AppointmentBuyerState> mapEventToState(
      AppointmentBuyerEvent event) async* {
    if (event is GetBuyerAppointmentEvent) {
      try {
        final GlobalResponse response =
            await AppointmentRepository().getBuyerAppointment();
        yield AppointmentBuyerResponse(response: response);
      } catch (e) {
        yield AppointmentBuyerError(message: e.toString());
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
        yield AppointmentBuyerError(message: e);
      }
    }
  }
}
