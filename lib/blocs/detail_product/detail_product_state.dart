part of 'detail_product_bloc.dart';

abstract class DetailProductState extends Equatable {
  final GlobalResponse response;
  final int carouselPosition;
  final List<Placemark> placemarks;
  final Position currentPosition;
  final GeolocationStatus geolocationStatus;

  const DetailProductState({this.response, this.carouselPosition, this.placemarks, this.currentPosition, this.geolocationStatus});

  @override
  List<Object> get props => [response, carouselPosition, placemarks, currentPosition, geolocationStatus];
}

class DetailProductInitial extends DetailProductState {
  DetailProductInitial({int carouselPosition}) : super(response:null, carouselPosition: carouselPosition, placemarks: null, currentPosition:null, geolocationStatus:null);
}

class DetailProductPermissionResponse extends DetailProductState {
  DetailProductPermissionResponse({GeolocationStatus geolocationStatus}) : super(response:null, carouselPosition: 0, placemarks: null, currentPosition:null, geolocationStatus:geolocationStatus);
}

class DetailProductResponse extends DetailProductState {
  final int carouselPosition;
  final GlobalResponse response;
  final List<Placemark> placemarks;
  final Position currentPosition;

  DetailProductResponse({this.carouselPosition, this.response, this.placemarks, this.currentPosition}): super(response:response, carouselPosition: carouselPosition, placemarks: placemarks, currentPosition:currentPosition, geolocationStatus:null);

  DetailProductResponse copyWith({GlobalResponse response, int carouselPosition, List<Placemark> placemarks, Position currentPosition}){
    return DetailProductResponse(
      carouselPosition: carouselPosition ?? this.carouselPosition,
      response: response ?? this.response,
      placemarks: placemarks ?? this.placemarks,
      currentPosition: currentPosition ?? this.currentPosition
    );
  }
}

class DetailProductError extends DetailProductState {
  final String message;

  DetailProductError({@required this.message});

  @override
  List<Object> get props => [message];
}

class InitiateChatResponse extends DetailProductState {
  final GlobalResponse response;
  final String receiverid;

  InitiateChatResponse({@required this.response, @required this.receiverid});

  @override
  List<Object> get props => [response, receiverid];
}

