import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';

part 'chat_messages_event.dart';
part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  @override
  ChatMessagesState get initialState => ChatMessagesInit();

  @override
  Stream<ChatMessagesState> mapEventToState(ChatMessagesEvent event) async* {
    if (event is ChatMessagesRequested) {
      yield ChatMessagesLoading();
      try {
        final GlobalResponse response = await ChatRepository().getRetrieveChatMesssages(room: event.room);
        yield ChatMessagesLoaded(response: response);
      } catch (e) {
        yield ChatMessagesError(message: e);
      }
    }
  }
}
