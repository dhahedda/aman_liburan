part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}

class NotificationResponseState extends NotificationState {
  final GlobalResponse response;

  NotificationResponseState({this.response});

  @override
  List<Object> get props => [response];
}

class NotificationConfirmationResponse extends NotificationState {
  final GlobalResponse response;

  NotificationConfirmationResponse({this.response});

  @override
  List<Object> get props => [response];
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError({@required this.message});

  @override
  List<Object> get props => [message];
}

