part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class GetNotificationEvent extends NotificationEvent {
  @override
  List<Object> get props => [];
}

class AcceptNotificationEvent extends NotificationEvent {
  final String appointmentId;

  AcceptNotificationEvent({@required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}

class RejectNotificationEvent extends NotificationEvent {
  final String appointmentId;

  RejectNotificationEvent({@required this.appointmentId});

  @override
  List<Object> get props => [appointmentId];
}

class SendTrustCoinEvent extends NotificationEvent {
  final SendTrustCoinParam param;

  SendTrustCoinEvent({@required this.param});

  @override
  List<Object> get props => [param];
}
