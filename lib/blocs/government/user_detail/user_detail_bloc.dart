import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_detail_event.dart';
part 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  @override
  UserDetailState get initialState => throw UserDetailInitial();

  @override
  Stream<UserDetailState> mapEventToState(
    UserDetailEvent event,
  ) async* {
  }

}
