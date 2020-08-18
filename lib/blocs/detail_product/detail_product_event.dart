part of 'detail_product_bloc.dart';

abstract class DetailProductEvent extends Equatable {
  const DetailProductEvent();

  @override
  List<Object> get props => [];
}

class GetApiDetailProductEvent extends DetailProductEvent {
  final String id;

  GetApiDetailProductEvent({this.id});

  @override
  List<Object> get props => [id];
}

class CarouselEvent extends DetailProductEvent {
  final int position;

  CarouselEvent({this.position});

  @override
  List<Object> get props => [position];
}

class PermissionEvent extends DetailProductEvent{
  final String id;
  final bool androidFusedLocation;

  PermissionEvent({this.id, this.androidFusedLocation});

  @override
  List<Object> get props => [id, androidFusedLocation];
}

class GeolocatorEvent extends DetailProductEvent {
  final double latitude;
  final double longitude;

  GeolocatorEvent({@required this.latitude, @required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

class GenerateChatRoomEvent extends DetailProductEvent{
  final String receiverid;

  GenerateChatRoomEvent({this.receiverid});

  @override
  List<Object> get props => [receiverid];
}
