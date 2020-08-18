part of 'chat_lobby_bloc.dart';

abstract class ChatLobbyEvent extends Equatable {
  const ChatLobbyEvent();

  @override
  List<Object> get props => [];
}

class ChatLobbyRequested extends ChatLobbyEvent {}