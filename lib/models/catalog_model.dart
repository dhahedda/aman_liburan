import 'package:aman_liburan/models/response/api_response.dart';

class CatalogModel{
  String id;
  int price;
  String title;
  String imageUrl;
  bool isWishlist;
  String availability;
  LocationResponse location;

  CatalogModel(this.id, this.price, this.title, this.imageUrl, this.isWishlist, this.availability, this.location);
}