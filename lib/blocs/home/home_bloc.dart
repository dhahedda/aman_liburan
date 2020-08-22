import 'dart:async';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:aman_liburan/models/response/api_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => OnHomeLoading();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetApiHomeEvent) {
      dynamic response = await HomeRepository().getPlace(params: EmptyParam());
      print(response);

      yield OnHomeResponse(response: response);
    }

    if (event is GetProductByCategory) {
      final currentState = state;

      if (currentState is OnHomeResponse) {
        GlobalResponse response = await HomeRepository().getProductCategory(categoryName: event.id);
        yield currentState.copyWith(response: response);
      }
    }
  }
}
