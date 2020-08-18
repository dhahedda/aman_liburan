part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatLobbyRequested extends ChatEvent {}

class ChatRoomNavigated extends ChatEvent {
  final ChatLobbyResponse currentChatLobbyResponse;

  const ChatRoomNavigated({@required this.currentChatLobbyResponse}) : assert(currentChatLobbyResponse != null);

  @override
  List<Object> get props => [currentChatLobbyResponse];
}

class ChatMessagesRequested extends ChatEvent {
  final String room;

  const ChatMessagesRequested({@required this.room}) : assert(room != null);

  @override
  List<Object> get props => [room];
}

class MessageReceived extends ChatEvent {
  final String message;
  final String userId;

  const MessageReceived({
    @required this.message,
    @required this.userId,
  })  : assert(message != null),
        assert(userId != null);

  @override
  List<Object> get props => [message, userId];
}

class MessageSent extends ChatEvent {
  final String message;

  const MessageSent({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class InitiateChatEvent extends ChatEvent {
  final String receiverId;

  const InitiateChatEvent({@required this.receiverId}) : assert(receiverId != null);

  @override
  List<Object> get props => [receiverId];
}

class CloseInitiateChatEvent extends ChatEvent {}