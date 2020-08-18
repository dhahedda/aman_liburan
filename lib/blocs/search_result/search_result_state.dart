part of 'search_result_bloc.dart';

abstract class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class OnLoading extends SearchResultState {}

class OnResponse extends SearchResultState {
  final GlobalResponse response;

  OnResponse({@required this.response});

  @override
  List<Object> get props => [response];
}

class OnError extends SearchResultState {
  final String message;

  OnError({@required this.message});

  @override
  List<Object> get props => [message];
}

