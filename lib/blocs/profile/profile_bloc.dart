import 'dart:async';

import 'package:aman_liburan/repositories/profile_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileInit();

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is GetProfileEvent) {
      yield ProfileLoading();
      try {
        final dynamic response = await ProfileRepository().getProfile(params: EmptyParam());
        yield ProfileResponse(response: response);
      } catch (e) {
        yield ProfileError(message: "Some Error => ${e.toString()}");
      }
    }
  }
}
