part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();

  @override
  List<Object> get props => [];
}

class ChatMessagesRequested extends ChatMessagesEvent {
  final String room;

  const ChatMessagesRequested({@required this.room}) : assert(room != null);

  @override
  List<Object> get props => [room];
}