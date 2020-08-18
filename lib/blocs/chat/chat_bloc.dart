import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/account_repository.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  @override
  ChatState get initialState => ChatState.initial();

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatLobbyRequested) {
      try {
        final chatResponse = await ChatRepository().postRetrieveChatLobby(params: EmptyParam());
        final profileResponse = await AccountRepository().getProfileInfo();
        yield state.copyWith(chatLobbyResponseList: chatResponse.data.chatLobby, userId: profileResponse.data.profile.id);
      } catch (e) {}
    }
    if (event is ChatRoomNavigated) {
      yield state.copyWith(currentChatLobbyResponse: event.currentChatLobbyResponse);
    }
    if (event is ChatMessagesRequested) {
      try {
        final response = await ChatRepository().getRetrieveChatMesssages(room: event.room);
        yield state.copyWith(messagesResponseList: response.data.messages);
      } catch (e) {}
    }
    if (event is MessageReceived) {
      List<RoomMessageResponse> messagesResponseList = state.messagesResponseList;
      messagesResponseList.add(RoomMessageResponse(message: event.message));
      yield state.copyWith(messagesResponseList: messagesResponseList);
    }
    if (event is MessageSent) {
      List<RoomMessageResponse> messagesResponseList = state.messagesResponseList;
      messagesResponseList.add(RoomMessageResponse(message: event.message));
      yield state.copyWith(messagesResponseList: messagesResponseList);
      // try {
      //   final GlobalResponse response = await ChatRepository().postInsertChatMessage(params: params(
      //     message: event.message,
      //     roomId: state.currentChatLobbyResponse.id,
      //     userId: state.currentChatLobbyResponse.userIds[1],
      //   ));
      //   yield state.copyWith(messagesResponseList: response.data.messages);
      // } catch (e) {}
    }
    if (event is InitiateChatEvent) {
      final response = await ChatRepository().getInitiateChat(receiverId: event.receiverId);
      yield state.copyWith(currentChatLobbyResponse: response.data.room);
    }
    if (event is CloseInitiateChatEvent) {
      yield state.copyWith(currentChatLobbyResponse: null);
    }
  }
}
