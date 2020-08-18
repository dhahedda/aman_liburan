import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:aman_liburan/components/data_session.dart';

import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/models/param/dashboard_param.dart';
import 'package:aman_liburan/repositories/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  @override
  DashboardState get initialState => OnDashboardLoading();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is GetApiDashboardEvent) {
      String username = await DataSession().getUsername();
      GlobalResponse response =
          await DashboardRepository().getDashboardApi(params: DashboardParam());
      if (response.status == "Success") {
        double latitude  = 43.070682;
        double longitude = 141.369445;

        List<Placemark> placemarks = [];
        try {
          placemarks =
              await Geolocator().placemarkFromCoordinates(latitude, longitude);
        } catch (e) {
          // Handle error location not found
          print("placemarks_error =>${e.toString()}");
          placemarks.add(Placemark(name: 'unknown_location'));
        }

        yield OnDashboardResponse(
          response: response,
          username: username,
          placemarks: placemarks,
        );
      } else {
        yield OnDashboardResponse(
          response: response,
          username: username,
          placemarks: <Placemark>[],
        );
      }
    }

    if (event is GetProductByCategory) {
      final currentState = state;

      if (currentState is OnDashboardResponse) {
        GlobalResponse response = await DashboardRepository()
            .getProductCategory(categoryName: event.id);
        yield currentState.copyWith(response: response);
      }
    }
  }
}
