import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/account_repository.dart';
import 'package:aman_liburan/repositories/signin_repository.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  @override
  AccountState get initialState => AccountInit();

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is GetAccountEvent) {
      yield AccountLoading();
      try {
        final GlobalResponse response =
            await AccountRepository().getAccountProfile(params: AccountParam());
        if (response.status == "Success") {
          double latitude = 43.070682;
          double longitude = 141.369445;

          List<Placemark> placemarks = [];
          try {
            placemarks = await Geolocator()
                .placemarkFromCoordinates(latitude, longitude);
          } catch (e) {
            // Handle error location not found
            print("placemarks_error =>${e.toString()}");
            placemarks.add(Placemark(name: 'unknown_location'));
          }

          yield AccountResponse(response: response, placemarks: placemarks, acceptCashOnDelivery: response.data.paymentMethod.cod);
        } else {
          yield AccountResponse(response: response, placemarks: <Placemark>[], acceptCashOnDelivery: response.data.paymentMethod.cod);
        }
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is GetSellerAccountEvent) {
      try {
        final GlobalResponse response = await AccountRepository()
            .getSellerAccountProfile(
                params: AccountSellerParam(userId: event.userId));
        if (response.status == "Success") {
          double latitude = 43.070682;
          double longitude = 141.369445;

          List<Placemark> placemarks = [];
          try {
            placemarks = await Geolocator()
                .placemarkFromCoordinates(latitude, longitude);
          } catch (e) {
            // Handle error location not found
            print("placemarks_error =>${e.toString()}");
            placemarks.add(Placemark(name: 'unknown_location'));
          }

          yield AccountResponse(response: response, placemarks: placemarks);
        } else {
          yield AccountResponse(response: response, placemarks: <Placemark>[]);
        }
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is UpdateProfileEvent) {
      try {
        final GlobalResponse response = await AccountRepository().updateProfile(params: event.updateProfileParam);
        yield UpdateProfileResponse(response: response);
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is UpdatePaymentEvent) {
      try {
        final GlobalResponse response = await AccountRepository().updatePayment(params: event.updatePaymentParam);
        yield UpdatePaymentResponse(response: response);
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is CheckBoxAccountEvent) {
      try {
        final currentState = state;
        final bool acceptCashOnDelivery = event.acceptCashOnDelivery;
        if (currentState is AccountResponse) {
          yield currentState.copyWith(acceptCashOnDelivery: acceptCashOnDelivery);
        }
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }

    if (event is SignOutEvent) {
      try {
        final GlobalResponse response = await SigninRepository().postSignOut(params: EmptyParam());
        yield AccountSignOutResponse(response: response);
      } catch (e) {
        yield AccountError(message: "Some Error => ${e.toString()}");
      }
    }
  }
}
