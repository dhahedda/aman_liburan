import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/models/param/api_param.dart';

import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';

part 'chat_lobby_event.dart';
part 'chat_lobby_state.dart';

class ChatLobbyBloc extends Bloc<ChatLobbyEvent, ChatLobbyState> {
  @override
  ChatLobbyState get initialState => ChatLobbyInit();

  @override
  Stream<ChatLobbyState> mapEventToState(ChatLobbyEvent event) async* {
    if(event is ChatLobbyRequested) {
      yield ChatLobbyLoading();
      try {
        final GlobalResponse response = await ChatRepository().postRetrieveChatLobby(params: EmptyParam());
        yield ChatLobbyLoaded(response: response);
      } catch (error) {
        yield ChatLobbyError(message: error);
      }
    }
  }
}
