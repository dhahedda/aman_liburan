import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:aman_liburan/models/response/global_response.dart';
import 'package:aman_liburan/repositories/aman_liburan/api_repository.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  @override
  MessagesState get initialState => MessagesInit();

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    if(event is MessagesSubmitted) {
      yield MessagesLoading();
      try {
        final GlobalResponse response = await ApiRepository().getSearch(query: event.query);
        yield RoomMessageResponse(query: event.query, response: response);
      } catch (_) {
        yield MessagesError(message: _);
      }
    }
  }
}
