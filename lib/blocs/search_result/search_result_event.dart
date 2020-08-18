part of 'search_result_bloc.dart';

abstract class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class GetApiSearchResultEvent extends SearchResultEvent {}