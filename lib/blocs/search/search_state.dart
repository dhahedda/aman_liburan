part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInit extends SearchState {}

class SearchLoading extends SearchState {}

class SearchResponse extends SearchState {
  final GlobalResponse response;

  const SearchResponse({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}
