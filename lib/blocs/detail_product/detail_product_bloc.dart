import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:aman_liburan/models/param/api_param.dart';
import 'package:aman_liburan/models/param/detail_product_param.dart';
import 'package:aman_liburan/models/response/api_response.dart';
import 'package:aman_liburan/repositories/chat_repository.dart';
import 'package:aman_liburan/repositories/detail_product_repository.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  Position currentPosition;

  void getCurrentPosition(bool androidFusedLocation) {
    Geolocator()
      ..forceAndroidLocationManager = !androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) {
        this.currentPosition = position;
      }).catchError((e) {
        print("Error =>" + e);
      });
  }

  @override
  DetailProductState get initialState =>
      DetailProductInitial(carouselPosition: 0);

  @override
  Stream<DetailProductState> mapEventToState(DetailProductEvent event) async* {
    if (event is PermissionEvent) {
      String productId = event.id;
      DetailProductParam params = DetailProductParam(id: productId);
      bool androidFusedLocation = event.androidFusedLocation;

      getCurrentPosition(androidFusedLocation);
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      if (geolocationStatus == GeolocationStatus.granted) {
        print("granted");
        try {
          final GlobalResponse response =
              await DetailProductRepository().getDetailProduct(params: params);
          if (response.status == "Success") {
            double latitude = response.data.item.location.latitude;
            double longitude = response.data.item.location.longitude;

            List<Placemark> placemarks = [];
            try {
              placemarks = await Geolocator()
                  .placemarkFromCoordinates(latitude, longitude);
            } catch (e) {
              // Handle error location not found
              print("placemarks_error =>${e.toString()}");
              placemarks.add(Placemark(name: 'unknown_location'));
            }
            yield DetailProductResponse(
              carouselPosition: 0,
              response: response,
              placemarks: placemarks,
              currentPosition: currentPosition,
            );
          } else {
            yield DetailProductResponse(
              carouselPosition: 0,
              response: response,
              currentPosition: currentPosition,
            );
          }
        } catch (e) {
          yield DetailProductError(message: e.toString());
        }
      } else if (geolocationStatus == GeolocationStatus.denied) {
        print("denied");
        yield DetailProductPermissionResponse(
            geolocationStatus: geolocationStatus);
      }
    }

    // Still cant call second event on listener, so i put this code on PermissionEvent (caused state didn't changes)
    if (event is GetApiDetailProductEvent) {
      String productId = event.id;
      DetailProductParam params = DetailProductParam(id: productId);

      print("Running => GetApiDetailProductEvent");
      try {
        final GlobalResponse response =
            await DetailProductRepository().getDetailProduct(params: params);
        if (response.status == "Success") {
          double latitude = response.data.item.location.latitude;
          double longitude = response.data.item.location.longitude;

          // getCurrentPosition();
          List<Placemark> placemarks =
              await Geolocator().placemarkFromCoordinates(latitude, longitude);
          yield DetailProductResponse(
              carouselPosition: 0,
              response: response,
              placemarks: placemarks,
              currentPosition: currentPosition);
        } else {
          yield DetailProductResponse(
              carouselPosition: 0,
              response: response,
              currentPosition: currentPosition);
        }
      } catch (e) {
        yield DetailProductError(message: e);
      }
    }

    if (event is CarouselEvent) {
      final currentState = state;
      int position = event.position;

      if (currentState is DetailProductResponse) {
        yield currentState.copyWith(carouselPosition: position);
      }
    }

    if (event is GenerateChatRoomEvent) {
      String receiverid = event.receiverid;

      try {
        final GlobalResponse response = await ChatRepository().getInitiateChat(
          receiverId: receiverid,
        );
        yield InitiateChatResponse(
          response: response,
          receiverid: receiverid,
        );
      } catch (e) {
        yield DetailProductError(message: e);
      }
    }
  }
}
