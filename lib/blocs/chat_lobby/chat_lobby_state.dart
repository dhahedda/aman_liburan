part of 'chat_lobby_bloc.dart';

abstract class ChatLobbyState extends Equatable {
  const ChatLobbyState();

  @override
  List<Object> get props => [];
}

class ChatLobbyInit extends ChatLobbyState {}

class ChatLobbyLoading extends ChatLobbyState {}

class ChatLobbyLoaded extends ChatLobbyState {
  final GlobalResponse response;

  const ChatLobbyLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ChatLobbyError extends ChatLobbyState {
  final String message;

  const ChatLobbyError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}
