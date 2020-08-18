part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchSubmitted extends SearchEvent {
  final String query;

  const SearchSubmitted({@required this.query}) : assert(query != null);

  @override
  List<Object> get props => [query];
}

class CategoryNavigated extends SearchEvent {
  final String category;

  const CategoryNavigated({@required this.category}) : assert(category != null);

  @override
  List<Object> get props => [category];
}

class SearchSortFilterEvent extends SearchEvent {
  final String query;
  final String category;
  final String sortBy;
  final String status;
  final int priceMin;
  final int priceMax;

  const SearchSortFilterEvent({
    this.query,
    this.category,
    @required this.sortBy,
    this.status,
    this.priceMin,
    this.priceMax,
  })  : assert(query != null || category != null),
        assert(sortBy != null);

  @override
  List<Object> get props => [query, category, sortBy];
}
