import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/models/param/search_param.dart';

import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  @override
  SearchState get initialState => SearchInit();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchSubmitted) {
      yield SearchLoading();
      try {
        final GlobalResponse response = await SearchRepository().getSearch(
          params: SearchParam(
            query: event.query,
            limit: 20,
          ),
        );
        yield SearchResponse(response: response);
      } catch (error) {
        yield SearchError(message: error);
      }
    }
    if (event is CategoryNavigated) {
      yield SearchLoading();
      try {
        final GlobalResponse response = await SearchRepository().getSearch(
          params: SearchParam(category: event.category),
        );
        yield SearchResponse(response: response);
      } catch (error) {
        yield SearchError(message: error);
      }
    }
    if (event is SearchSortFilterEvent) {
      yield SearchLoading();
      try {
        final GlobalResponse response = await SearchRepository().getSearch(
          params: SearchParam(
            query: event.query,
            category: event.category,
            sortBy: event.sortBy,
            priceMin: event.priceMin,
            priceMax: event.priceMax,
            status: event.status,
          ),
        );
        yield SearchResponse(response: response);
      } catch (error) {
        yield SearchError(message: error);
      }
    }
  }
}
