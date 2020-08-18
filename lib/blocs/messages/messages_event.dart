part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();
}

class MessagesSubmitted extends MessagesEvent {
  final String query;

  const MessagesSubmitted({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}