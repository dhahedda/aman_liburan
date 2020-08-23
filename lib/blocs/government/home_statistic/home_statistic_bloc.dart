import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_statistic_event.dart';
part 'home_statistic_state.dart';

class HomeStatisticBloc extends Bloc<HomeStatisticEvent, HomeStatisticState> {
  @override
  HomeStatisticState get initialState => HomeStatisticInitial();

  @override
  Stream<HomeStatisticState> mapEventToState(
    HomeStatisticEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }

}
