part of 'chat_messages_bloc.dart';

abstract class ChatMessagesState extends Equatable {
  const ChatMessagesState();

  @override
  List<Object> get props => [];
}

class ChatMessagesInit extends ChatMessagesState {}

class ChatMessagesLoading extends ChatMessagesState {}

class ChatMessagesLoaded extends ChatMessagesState {
  final GlobalResponse response;

  const ChatMessagesLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ChatMessagesError extends ChatMessagesState {
  final String message;

  const ChatMessagesError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}
