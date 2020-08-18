part of 'messages_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInit extends MessagesState {}

class MessagesLoading extends MessagesState {}

class RoomMessageResponse extends MessagesState {
  final String query;
  final GlobalResponse response;

  const RoomMessageResponse({@required this.query, @required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class MessagesError extends MessagesState {
  final String message;

  MessagesError({@required this.message});

  @override
  List<Object> get props => [message];
}

