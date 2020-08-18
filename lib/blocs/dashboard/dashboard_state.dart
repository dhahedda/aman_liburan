part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable {
  final GlobalResponse response;
  final String username;
  final List<Placemark> placemarks;

  const DashboardState({this.response, this.username, this.placemarks});

  @override
  List<Object> get props => [response, username, placemarks];
}

class OnDashboardLoading extends DashboardState {}

class OnDashboardResponse extends DashboardState {
  final GlobalResponse response;
  final String username;
  final List<Placemark> placemarks;

  OnDashboardResponse({ @required this.response, @required this.username, @required this.placemarks}): super(response:response, username:username, placemarks:placemarks);

  OnDashboardResponse copyWith({GlobalResponse response, String username}){
    return OnDashboardResponse(
      response: response ?? this.response,
      username: username ?? this.username,
      placemarks: placemarks ?? this.placemarks,
    );
  }

  @override
  List<Object> get props => [response, username, placemarks];
}

class OnDashboardError extends DashboardState {
  final String message;

  OnDashboardError({@required this.message});

  @override
  List<Object> get props => [message];
}

