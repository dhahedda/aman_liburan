import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:aman_liburan/models/response/global_response.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {

  @override
  SearchResultState get initialState => OnLoading();

  @override
  Stream<SearchResultState> mapEventToState(SearchResultEvent event) async* {
    // if(event is GetApiSearchResultEvent) {
    //   GlobalResponse response = await ApiRepository().getSearchResult();
    //   yield OnResponse(response: response);
    // }
  }
}
