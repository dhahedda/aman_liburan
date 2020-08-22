part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class OnHomeLoading extends HomeState {}

class OnHomeResponse extends HomeState {
  final dynamic response;

  OnHomeResponse({@required this.response});

  OnHomeResponse copyWith({GlobalResponse response, String username}) {
    return OnHomeResponse(response: response ?? this.response);
  }

  @override
  List<Object> get props => [response];
}

class OnHomeError extends HomeState {
  final String message;

  OnHomeError({@required this.message});

  @override
  List<Object> get props => [message];
}
