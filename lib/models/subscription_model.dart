import 'package:meta/meta.dart';

class SubscriptionModel{
  String title;
  String price;
  String discount;
  bool isSelected;

  SubscriptionModel({ @required this.title, @required this.price, @required this.discount, @required this.isSelected});
}